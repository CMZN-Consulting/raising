-- | The harness, compiled: with no arguments it runs the main demonstration in this process;
-- with @--adapter@ it runs the composition with the adapter command that follows, for the
-- number of units of Theta given by @--units@, seven by default.
module Main (main) where

import Demonstration.Harness (demonstrate, demonstrateWith)
import System.Environment (getArgs)
import System.Exit (exitFailure)
import Text.Read (readMaybe)

main :: IO ()
main = getArgs >>= dispatch
  where
    dispatch [] = demonstrate
    dispatch ("--units" : u : rest) | Just n <- readMaybe u = withAdapter n rest
    dispatch rest = withAdapter 7 rest
    withAdapter n ("--adapter" : cmd : args) = demonstrateWith cmd args n
    withAdapter _ _ = do
      putStrLn "usage: harness [--units N] [--adapter COMMAND ARGUMENTS]"
      exitFailure
