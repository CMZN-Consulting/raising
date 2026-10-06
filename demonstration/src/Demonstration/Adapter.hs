-- | The adapter: the one part of the harness that is particular to a platform. An adapter is
-- bound to one platform and hydrates it: given the call of a unit of Theta, the platform,
-- the framing, the seed and the environment, it answers with the text the model wrote and
-- the hash of the weights it actually ran. It is given nothing else of the harness and
-- returns nothing else: the room, the memory and the record are the harness's, and every tool
-- is run by the harness, so nothing reaches the individual that is not on its record.
--
-- The hydration of the individual's definition is a pure function of the four inputs. A real
-- model is pure only when its environment makes it so, so here purity is measured, not
-- assumed: 'replayCheck' hydrates one call twice and compares, and 'guarded' refuses an answer
-- from weights other than the platform's, a change of weights being a death.
module Demonstration.Adapter
  ( -- * The interface
    Adapter (..)
  , Hydrated (..)
  , Refused (..)
  , guarded
  , replayCheck
    -- * Adapters in this process
  , pureAdapter
    -- * Adapters in another process
  , encodeCall
  , decodeCall
  , encodeHydrated
  , decodeHydrated
  , withSubprocess
  ) where

import Control.DeepSeq (NFData)
import Control.Exception (bracket, throwIO)
import GHC.Generics (Generic)
import Demonstration.Mundus (Call (..))
import MundusIndividual.Hydration qualified as Ind
import MundusIndividual.Platform qualified as Ind
import MundusLanguage.Types (Text)
import System.IO (BufferMode (LineBuffering), Handle, hFlush, hGetLine, hPutStrLn, hSetBuffering)
import System.Process (CreateProcess (..), StdStream (CreatePipe), cleanupProcess, createProcess, proc)
import Text.Read (readMaybe)

-- | What an adapter answers: the text, and the hash of the weights that wrote it.
data Hydrated = Hydrated
  { hydratedText :: Text
  , hydratedWeights :: Int
  }
  deriving stock (Eq, Show, Generic)
  deriving anyclass (NFData)

-- | An adapter: the platform it is bound to, and the hydration of that platform. It holds a
-- function, so it derives nothing.
data Adapter = Adapter
  { adapterPlatform :: Ind.Platform
  , adapterHydrate :: Call -> IO Hydrated
  }

-- | Why the harness refuses an answer.
data Refused
  = -- | the call is for a platform the adapter is not bound to
    WrongPlatform Ind.Platform Ind.Platform
  | -- | the weights that answered are not the platform's: the hash expected, the hash found
    WeightsChanged Int Int
  | -- | the same call answered twice with two texts
    NotReplayed Text Text
  deriving stock (Eq, Show, Generic)
  deriving anyclass (NFData)

-- | The harness's guard around an adapter: the call must be for the adapter's platform, and
-- the answer must come from that platform's weights.
guarded :: Adapter -> Call -> IO (Either Refused Hydrated)
guarded a c
  | callPlatform c /= adapterPlatform a = pure (Left (WrongPlatform (callPlatform c) (adapterPlatform a)))
  | otherwise = do
      h <- adapterHydrate a c
      let expected = Ind.weightsHash (adapterPlatform a)
      pure $
        if hydratedWeights h == expected
          then Right h
          else Left (WeightsChanged expected (hydratedWeights h))

-- | The replay check: one call hydrated twice, through the guard. The text when the two
-- agree; the refusal otherwise. This is what earns an environment its @replayed@ flag.
replayCheck :: Adapter -> Call -> IO (Either Refused Text)
replayCheck a c = do
  r1 <- guarded a c
  r2 <- guarded a c
  pure $ case (r1, r2) of
    (Right h1, Right h2)
      | hydratedText h1 == hydratedText h2 -> Right (hydratedText h1)
      | otherwise -> Left (NotReplayed (hydratedText h1) (hydratedText h2))
    (Left e, _) -> Left e
    (_, Left e) -> Left e

-- | A pure hydration as an adapter of a platform: it answers with the platform's own weights,
-- since a pure function has no others.
pureAdapter :: Ind.Platform -> Ind.Hydration -> Adapter
pureAdapter p h =
  Adapter p $ \(Call cp f s e) ->
    pure (Hydrated (Ind.hydrate h cp f s e) (Ind.weightsHash p))

-- | A call on the wire, one line of numbers: the seed, the framing's length, the framing.
-- The platform and the environment are the adapter's own configuration and are checked by
-- the guard, not sent.
encodeCall :: Call -> String
encodeCall c = unwords (map show (callSeed c : length (callFraming c) : callFraming c))

-- | A call read back from the wire, onto a platform and an environment the reader holds.
decodeCall :: Ind.Platform -> Ind.Environment -> String -> Maybe Call
decodeCall p e l = do
  ns <- traverse readMaybe (words l)
  case ns of
    s : n : rest | n == length rest -> Just (Call p rest s e)
    _ -> Nothing

-- | An answer on the wire, one line of numbers: the weights' hash, the text's length, the text.
encodeHydrated :: Hydrated -> String
encodeHydrated h = unwords (map show (hydratedWeights h : length (hydratedText h) : hydratedText h))

-- | An answer read back from the wire.
decodeHydrated :: String -> Maybe Hydrated
decodeHydrated l = do
  ns <- traverse readMaybe (words l)
  case ns of
    w : n : rest | n == length rest -> Just (Hydrated rest w)
    _ -> Nothing

-- | An adapter in another process, for the time of an action: the command is started once,
-- each call is written to its input as one line and its answer read from its output as one
-- line. The process is stopped when the action ends.
withSubprocess :: Ind.Platform -> FilePath -> [String] -> (Adapter -> IO a) -> IO a
withSubprocess p cmd args k =
  bracket
    (createProcess (proc cmd args) {std_in = CreatePipe, std_out = CreatePipe})
    cleanupProcess
    ( \case
        (Just hin, Just hout, _, _) -> do
          hSetBuffering hin LineBuffering
          k (Adapter p (exchange hin hout))
        _ -> throwIO (userError ("the adapter " ++ cmd ++ " gave no pipes"))
    )
  where
    exchange :: Handle -> Handle -> Call -> IO Hydrated
    exchange hin hout c = do
      hPutStrLn hin (encodeCall c)
      hFlush hin
      l <- hGetLine hout
      maybe (throwIO (userError ("the adapter's answer is not a line of the wire: " ++ l))) pure (decodeHydrated l)
