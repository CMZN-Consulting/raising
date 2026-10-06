-- | The harness: the composition of mundus run by an adapter, one unit of Theta at a time.
-- Each unit, the harness gives the adapter the call of the unit, guards the answer, and steps
-- the world with the text; a refused answer stops the run and is reported with the world it
-- stopped at. The world a run leaves is the one the record's texts rebuild.
module Demonstration.Harness
  ( runHarness
  , printEvents
  , demonstrate
  , demonstrateWith
  ) where

import Control.Monad (forM_)
import Demonstration.Adapter
import Demonstration.Mundus
import MundusIndividual.Declaration qualified as Ind
import MundusIndividual.Definition qualified as Ind
import MundusIndividual.Platform qualified as Ind
import MundusMemoryArtifact.Knobs qualified as Mem
import MundusMemoryArtifact.Types qualified as Mem
import MundusRoom.Definition qualified as Room

-- | Runs @n@ units of Theta with an adapter: the events of the units run, and the world at
-- the end, with the refusal that stopped the run if one did.
runHarness :: Housing -> Adapter -> World -> Int -> IO ([Event], World, Maybe Refused)
runHarness hs a = go 1 []
  where
    go th acc w n
      | n <= 0 = pure (reverse acc, w, Nothing)
      | otherwise = do
          r <- guarded a (callAt hs w)
          case r of
            Left e -> pure (reverse acc, w, Just e)
            Right h -> do
              let w' = stepWith hs (hydratedText h) w
              go (th + 1) (eventOf hs th w' : acc) w' (n - 1)

-- | The events of a run, one line per unit of Theta.
printEvents :: [Event] -> IO ()
printEvents evs = do
  putStrLn "  theta | text | read as | decision | gap | days | infos | well-formed | record | framing"
  forM_ evs $ \e ->
    putStrLn $
      "  "
        ++ show (eventTheta e)
        ++ " | "
        ++ show (eventText e)
        ++ " | "
        ++ maybe "unread" show (eventLine e)
        ++ " | "
        ++ show (eventDecision e)
        ++ " | "
        ++ show (eventGap e)
        ++ " | "
        ++ show (eventDays e)
        ++ " | "
        ++ show (eventInfos e)
        ++ " | "
        ++ show (eventWellFormed e)
        ++ " | "
        ++ show (eventRecordOk e)
        ++ " | "
        ++ show (eventFramingSize e)
        ++ (if eventFits e then " fits" else " exceeds")
  putStrLn ("  every unit well-formed and attributed: " ++ show (all eventWellFormed evs && all eventRecordOk evs))

-- | The structure initialized from the definitions' texts, as the harness reports it.
printHousing :: Housing -> World -> IO ()
printHousing hs w0 = do
  putStrLn "initialized from the definitions' texts:"
  putStrLn ("  vocabulary " ++ show (vocab hs) ++ ", read from " ++ show Room.vocabText)
  putStrLn ("  window " ++ show (window hs) ++ ", read from " ++ show Room.windowText)
  putStrLn ("  knobs read from " ++ show Mem.knobsText)
  putStrLn ("  platform " ++ Ind.platformName (Ind.paramsPlatform (individual hs)) ++ ", read from " ++ show Ind.platformText)
  putStrLn ("  environment read from " ++ show Ind.environmentText)
  putStrLn ("  record of " ++ show (length (record w0)) ++ " lines; memory of " ++ show (Mem.memoryCount (memory w0)) ++ " infos after the first night")

-- | One run of the harness with an adapter, reported, and its record replayed.
reportRun :: Housing -> World -> Adapter -> Int -> IO ()
reportRun hs w0 a n = do
  (evs, w, refused) <- runHarness hs a w0 n
  printEvents evs
  maybe (pure ()) (\e -> putStrLn ("  stopped, the answer refused: " ++ show e)) refused
  let texts = map eventText evs
  putStrLn ("  the record's texts rebuild the world: " ++ show (replayRecord hs w0 texts == w))

-- | The main demonstration, in this process: the replay of the room's recorded run, then the
-- hydration the individual's definition states, which always goes to bed.
demonstrate :: IO ()
demonstrate = case initialize (recordedRun 128) of
  Left err -> putStrLn ("initialization " ++ err)
  Right (hs, w0) -> do
    putStrLn "raising: the harness of mundus"
    putStrLn ""
    printHousing hs w0
    let p = Ind.paramsPlatform (individual hs)
    putStrLn ""
    putStrLn "adapter: the room's recorded run, replayed, in this process"
    reportRun hs w0 (pureAdapter p (recordedRun 128)) (length Room.run)
    putStrLn ""
    putStrLn "adapter: the hydration the individual's definition states, which always goes to bed"
    reportRun hs w0 (pureAdapter p Ind.tired) 3

-- | The demonstration with an adapter in another process, for @n@ units of Theta.
demonstrateWith :: FilePath -> [String] -> Int -> IO ()
demonstrateWith cmd args n = case initialize (recordedRun 128) of
  Left err -> putStrLn ("initialization " ++ err)
  Right (hs, w0) -> do
    putStrLn "raising: the harness of mundus"
    putStrLn ""
    printHousing hs w0
    putStrLn ""
    putStrLn ("adapter: " ++ unwords (cmd : args) ++ ", in another process")
    withSubprocess (Ind.paramsPlatform (individual hs)) cmd args $ \a -> do
      r <- replayCheck a (callAt hs w0)
      putStrLn ("  replay check on the first call: " ++ either show (const "the same text twice") r)
      reportRun hs w0 a n
