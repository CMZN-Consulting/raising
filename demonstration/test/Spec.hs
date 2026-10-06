-- | The adherence of the composition, measured: the structure, initialized from the
-- definitions' data and run on the replay of the room's recorded run, reproduces the values
-- the Lean proves of each part, and the root's maps keep their laws on it. One line per
-- check; the suite exits with one when any check fails.
module Main (main) where

import Control.Monad (unless)
import Data.IORef (atomicModifyIORef', newIORef)
import Demonstration.Adapter
import Demonstration.Harness (runHarness)
import Demonstration.Mundus
import MundusIndividual.Declaration qualified as Ind
import MundusIndividual.Definition qualified as Ind
import MundusIndividual.Platform qualified as Ind
import MundusIndividual.Record qualified as Rec
import MundusLanguage.Forms qualified as L
import MundusMemoryArtifact.WellFormed qualified as Mem
import MundusRoom.Definition qualified as Room
import MundusRoom.Manual qualified as Manual
import MundusRoom.Trace qualified as Trace
import Raising.Root qualified as R
import System.Exit (exitFailure)
import Test.QuickCheck hiding (replay)

-- | The structure on the replay of the recorded run, or the reason it did not initialize.
recorded :: (Housing, World)
recorded = either error id (initialize (recordedRun 128))

housing :: Housing
housing = fst recorded

world0 :: World
world0 = snd recorded

-- | The world after @n@ units of Theta on the recorded run.
after :: Int -> World
after = R.run (frameOf housing) world0

-- | The structure on the hydration the individual's definition states.
tiredStructure :: (Housing, World)
tiredStructure = either error id (initialize Ind.tired)

seven :: Int
seven = length Room.run

checks :: [(String, Property)]
checks =
  [ ("initialize", once (vocab housing === 128 .&&. window housing === 2 .&&. length (record world0) === 3))
  , ("initial_wellFormed", once (wellFormedAt 0))
  , ("composed_trace", once (roomTrace (after seven) === Room.trace))
  , ( "composed_decisions"
    , once
        ( map Manual.decision (roomTrace (after seven))
            === [Manual.Accepted, Manual.Accepted, Manual.Refused, Manual.Accepted, Manual.Accepted, Manual.Accepted, Manual.Accepted]
        )
    )
  , ("composed_arrives", once (Room.gap (header (after seven)) === 0))
  , ("composed_three_days", once (Trace.days Room.manual (roomTrace (after seven)) === 3))
  , ("composed_valid", once (Trace.valid Room.manual [] (roomTrace (after seven))))
  , ("record_grows_by_one", once (conjoin [length (record (after n)) === 3 + n | n <- [0 .. seven]]))
  , ("record_burden", once (conjoin [counterexample (show n) (recordOk (after n)) | n <- [0 .. seven]]))
  , ("memory_burden", once (conjoin [counterexample (show n) (wellFormedAt n) | n <- [0 .. seven]]))
  , ("record_lines_are_the_texts", once (map Rec.text (drop 3 (record (after seven))) === Room.run))
  , ("past_the_recording_the_bed", once (Manual.proposal (last (roomTrace (after (seven + 1)))) === [L.endOfText 128]))
  , ("framings_fit", once (conjoin [counterexample (show (eventTheta e)) (eventFits e) | e <- observe housing world0 seven]))
  , ("run_add", forAll (choose (0, 4)) $ \a -> forAll (choose (0, 4)) $ \b -> R.run (frameOf housing) world0 (a + b) === R.run (frameOf housing) (R.run (frameOf housing) world0 a) b)
  , ("kit_refuses_unknown", once (R.arrowMap (R.apply (memoryKit 128 (memoryCtx housing)) [11, 11]) (memory world0) === memory world0))
  , ("kit_silent", once (R.arrowMap (R.apply (memoryKit 128 (memoryCtx housing)) []) (memory world0) === memory world0))
  , ("tired_every_unit_a_bed", once (let (h, w) = tiredStructure in Trace.days (roomManual h) (roomTrace (R.run (frameOf h) w 5)) === 5))
  , ("tired_wellFormed", once (let (h, w) = tiredStructure in conjoin [eventWellFormed e && eventRecordOk e | e <- observe h w 5]))
  , ("record_rebuilds", once (replayRecord housing world0 Room.run === after seven))
  , ("harness_equals_pure", once (ioProperty (harnessWorld (pureAdapter thePlatform (recordedRun 128)))))
  , ("subprocess_equals_pure", once (ioProperty (withSubprocess thePlatform "replay-adapter" [] harnessWorld)))
  , ("subprocess_replayed", once (ioProperty (withSubprocess thePlatform "replay-adapter" [] (\a -> (=== Right [3, 0, 20]) <$> replayCheck a (callAt housing world0)))))
  , ("guard_weights_changed", once (ioProperty ((=== Left (WeightsChanged 48879 1)) <$> guarded wrongWeights (callAt housing world0))))
  , ("guard_wrong_platform", once (ioProperty (either isWrongPlatform (const False) <$> guarded otherPlatform (callAt housing world0))))
  , ("replay_check_pure", once (ioProperty ((=== Right [3, 0, 20]) <$> replayCheck (pureAdapter thePlatform (recordedRun 128)) (callAt housing world0))))
  , ("replay_check_flaky", once (ioProperty (flaky >>= \a -> either isNotReplayed (const False) <$> replayCheck a (callAt housing world0))))
  , ("harness_stops_on_refusal", once (ioProperty ((\(evs, w, r) -> evs === [] .&&. w === world0 .&&. r === Just (WeightsChanged 48879 1)) <$> runHarness housing wrongWeights world0 3)))
  , ("wire_call_roundtrip", forAll (resize 30 (listOf (choose (0, 127)))) $ \f -> forAll (choose (0, 1000)) $ \sd -> let c = Call Ind.platform f sd Ind.environment in decodeCall Ind.platform Ind.environment (encodeCall c) === Just c)
  , ("wire_answer_roundtrip", forAll (resize 30 (listOf (choose (0, 127)))) $ \t -> forAll (choose (0, 100000)) $ \wh -> decodeHydrated (encodeHydrated (Hydrated t wh)) === Just (Hydrated t wh))
  ]
  where
    recordOk w = Rec.attributed (record w) && Rec.resolves (record w)
    wellFormedAt n = Mem.wellFormed (memoryCtx housing) (memory (after n))

-- | The platform the structure was initialized with.
thePlatform :: Ind.Platform
thePlatform = Ind.paramsPlatform (individual housing)

-- | The harness run seven units with an adapter leaves the world the pure step leaves.
harnessWorld :: Adapter -> IO Property
harnessWorld a = do
  (evs, w, r) <- runHarness housing a world0 seven
  pure (length evs === seven .&&. r === Nothing .&&. w === after seven)

-- | An adapter of the right platform answering from other weights.
wrongWeights :: Adapter
wrongWeights = Adapter thePlatform (\_ -> pure (Hydrated [L.endOfText 128] 1))

-- | An adapter bound to another platform.
otherPlatform :: Adapter
otherPlatform = pureAdapter (Ind.Platform (Ind.Series "Other") (Ind.Version 1) 1) Ind.tired

-- | An adapter that answers the same call with two texts in turn.
flaky :: IO Adapter
flaky = do
  n <- newIORef (0 :: Int)
  pure $ Adapter thePlatform $ \_ -> do
    k <- atomicModifyIORef' n (\x -> (x + 1, x))
    pure (Hydrated (if even k then [3, 0, 20] else [L.endOfText 128]) (Ind.weightsHash thePlatform))

isWrongPlatform :: Refused -> Bool
isWrongPlatform = \case
  WrongPlatform {} -> True
  _ -> False

isNotReplayed :: Refused -> Bool
isNotReplayed = \case
  NotReplayed {} -> True
  _ -> False

main :: IO ()
main = do
  results <- mapM run1 checks
  let failed = length (filter not results)
  putStrLn (show (length results - failed) ++ " of " ++ show (length results) ++ " checks passed")
  unless (failed == 0) exitFailure
  where
    run1 (name, prop) = do
      r <- quickCheckWithResult stdArgs {chatty = False, maxSuccess = 100} prop
      let ok = isSuccess r
      putStrLn ((if ok then "ok    " else "FAIL  ") ++ name ++ ": " ++ output r)
      pure ok
