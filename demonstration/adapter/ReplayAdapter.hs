-- | The reference adapter, out of process: it speaks the harness's wire on its input and
-- output and hydrates the platform of mundus by replaying the room's recorded run, a pure
-- function of the framing it is sent. It is what a model's adapter replaces.
module Main (main) where

import Demonstration.Adapter (Hydrated (..), decodeCall, encodeHydrated)
import Demonstration.Mundus (Call (..), recordedRun)
import MundusIndividual.Definition qualified as Ind
import MundusIndividual.Hydration qualified as Ind
import MundusIndividual.Platform qualified as Ind
import System.IO (BufferMode (LineBuffering), hIsEOF, hSetBuffering, stdin, stdout)

main :: IO ()
main = do
  hSetBuffering stdout LineBuffering
  loop
  where
    loop = do
      eof <- hIsEOF stdin
      if eof
        then pure ()
        else do
          l <- getLine
          case decodeCall Ind.platform Ind.environment l of
            Nothing -> putStrLn "0 0"
            Just (Call p f s e) ->
              putStrLn (encodeHydrated (Hydrated (Ind.hydrate (recordedRun 128) p f s e) (Ind.weightsHash p)))
          loop
