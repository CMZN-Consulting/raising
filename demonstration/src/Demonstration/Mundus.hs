-- | The composition of mundus: the language, the memory, the room and the individual in one
-- structure, initialized from the texts the four definitions state, and run by one outer
-- frame. One unit of Theta is one hydration: the individual writes a text from the framing it
-- reads, the room decides on the text, the memory's toolkit answers an accepted text, and the
-- individual's line is appended to its record. The bed ends a day: the memory's stop, then the
-- night that starts the next day.
module Demonstration.Mundus
  ( -- * The housing and the world
    Housing (..)
  , World (..)
  , contextLimit
  , desk
  , policy0
  , dayZero
  , initialize
    -- * The framing the individual reads
  , contextOf
  , framingOf
  , renderFraming
  , entries
    -- * Hydrations
  , replay
  , recordedRun
    -- * The memory's toolkit and the step
  , answer
  , memoryKit
  , Call (..)
  , callAt
  , stepWith
  , stepWorld
  , frameOf
  , replayRecord
    -- * A run, observed
  , Event (..)
  , eventOf
  , observe
  ) where

import Control.DeepSeq (NFData)
import Control.Monad (unless)
import GHC.Generics (Generic)
import MundusIndividual.Declaration qualified as Ind
import MundusIndividual.Definition qualified as Ind
import MundusIndividual.Hydration qualified as Ind
import MundusIndividual.Platform qualified as Ind
import MundusIndividual.Record qualified as Rec
import MundusLanguage.Forms qualified as L
import MundusLanguage.Types (Line (..), Name, Text, Theta, allTools, toolCode)
import MundusMemoryArtifact.Append qualified as Mem
import MundusMemoryArtifact.Day qualified as Mem
import MundusMemoryArtifact.Definition qualified as Mem
import MundusMemoryArtifact.Knobs qualified as Mem
import MundusMemoryArtifact.Tools qualified as Mem
import MundusMemoryArtifact.Types qualified as Mem
import MundusMemoryArtifact.WellFormed qualified as Mem
import MundusRoom.Definition qualified as Room
import MundusRoom.Framing qualified as Room
import MundusRoom.Manual qualified as Manual
import MundusRoom.Trace qualified as Trace
import Raising.Root qualified as R

-- | What the definitions fix and a run does not change: the vocabulary and the window of the
-- room, the context of the memory, the room's manual, and the housing of the individual. It
-- holds functions, so it derives nothing.
data Housing = Housing
  { vocab :: Int
  , window :: Int
  , memoryCtx :: Mem.Ctx
  , roomManual :: Manual.Manual Text Text
  , individual :: Ind.IndividualParams
  }

-- | The world at a unit of Theta: the room's header and trace, the memory, the record.
data World = World
  { header :: Text
  , roomTrace :: [Manual.Iteration Text]
  , memory :: Mem.Memory
  , record :: Rec.Record
  }
  deriving stock (Eq, Show, Generic)
  deriving anyclass (NFData)

-- | The context limit a framing must fit, the limit the week of mundus is checked against.
contextLimit :: Int
contextLimit = 128

-- | The desk, the writer of the memory's day 0, as the memory library's witness names it.
desk :: Name
desk = 3

-- | The policy of epoch 0, as the memory library's witness has it.
policy0 :: Mem.Policy
policy0 = Mem.Policy 1 2 [3]

-- | The desk's day 0, as the memory library's witness has it: the desk declares the ten
-- tools in the toolkit, shelves the list of recipes (recipe 5, bound 4), and writes the policy
-- of epoch 0 with the reason 70. Each is offered as an info is offered, so a draft the memory
-- refused would leave the refusal instead. Without day 0 the toolkit declares no tool, and the
-- memory refuses every call.
dayZero :: Mem.Ctx -> Mem.Memory -> Mem.Memory
dayZero c m0 = foldl offer m0 drafts
  where
    drafts =
      [(Mem.Toolkit, Mem.Draft desk Mem.KTool [toolCode t] []) | t <- allTools]
        ++ [ (Mem.StoreShared, Mem.Draft desk (Mem.KShelf Mem.SRecipes) [5, 4] [])
           , (Mem.StoreShared, Mem.Draft desk Mem.KPolicy (Mem.policyKey policy0 ++ [70]) [])
           ]
    offer m (l, d) = Mem.step c m l (Mem.mkInfo c m l d)

-- | Reads what the definitions state and builds the structure: the vocabulary and the window
-- from the room's texts, the knobs from the memory's, the platform and the environment from
-- the individual's, with the hydration given. The world starts on the empty header and the
-- empty trace, on the memory's empty memory after the desk's day 0 and the first start of
-- day, and on the record of the individual's definition. A text that its checker refuses
-- stops the initialization, named.
initialize :: Ind.Hydration -> Either String (Housing, World)
initialize h = do
  v <- note "the vocabulary text" (Room.readNat Room.vocabText)
  w <- note "the window text" (Room.readNat Room.windowText)
  k <- note "the knobs text" (Mem.readKnobs Mem.knobsText)
  p <- note "the platform text" (Ind.readPlatform Ind.platformText)
  e <- note "the environment text" (Ind.readEnvironment Ind.environmentText)
  unless (Ind.admitted e) (Left "the environment is not admitted")
  unless (Rec.attributed Ind.record && Rec.resolves Ind.record) (Left "the definition's record")
  let c = Mem.ctx {Mem.ctxP = k}
      q = Ind.IndividualParams p e h [] 0
  pure (Housing v w c Room.manual q, World [] [] (Mem.startDay c (dayZero c Mem.memoryEmpty)) Ind.record)
  where
    note what = maybe (Left ("refused: " ++ what)) Right

-- | The context the individual reads: its record, each line's text after its length.
contextOf :: Rec.Record -> Room.Context
contextOf = concatMap (\l -> length (Rec.text l) : Rec.text l)

-- | The framing at a world: the front header of the room of mundus over the record.
framingOf :: World -> Room.Framing
framingOf w = Room.frame (contextOf (record w)) Room.frontHeader

-- | A framing as the individual's text: the header's text after its length, then the context.
renderFraming :: Room.Framing -> Ind.Framing
renderFraming f = let ht = Room.text (Room.header f) in length ht : ht ++ Room.context f

-- | The entries of a text written length first, if it is one.
entries :: Text -> Maybe [Text]
entries [] = Just []
entries t = case L.splitAt t of
  Just (x, rest) -> (x :) <$> entries rest
  Nothing -> Nothing

-- | A hydration that replays recorded texts, a pure function of the framing alone: it reads
-- the framing's entries, the header and then the record, and past the first @start@ lines of
-- the record writes the recorded text for the line it is at; past the recording, the bed.
replay :: Int -> Int -> [Text] -> Ind.Hydration
replay v start texts = Ind.Hydration $ \_ f _ _ -> case entries f of
  Just (_ : ls)
    | n <- length ls - start
    , n >= 0
    , n < length texts ->
        texts !! n
  _ -> [L.endOfText v]

-- | The replay of the room's recorded run, after the record of the individual's definition.
recordedRun :: Int -> Ind.Hydration
recordedRun v = replay v (length Ind.record) Room.run

-- | The memory's answer to a line: the stop ends the day and the night starts the next one;
-- every other line is the tool's step.
answer :: Mem.Ctx -> Line -> Mem.Memory -> Mem.Memory
answer c Stop m = Mem.startDay c (Mem.toolStep c m Stop)
answer c l m = Mem.toolStep c m l

-- | The memory's toolkit in the root's sense: a tool under each code of the forms line and
-- the bed under the end of text, each reading its call and answering with the memory's step.
-- A call under any other name is refused: the identity.
memoryKit :: Int -> Mem.Ctx -> R.Toolkit Mem.Memory
memoryKit v c =
  [ R.Tool n (\args -> R.Arrow (\m -> maybe m (\l -> answer c l m) (L.read v (n : args))))
  | n <- L.forms ++ [L.endOfText v]
  ]

-- | The four inputs of one hydration, as the harness gives them: the platform and the
-- environment of the housing, the framing the world shows, and the housing's seed.
data Call = Call
  { callPlatform :: Ind.Platform
  , callFraming :: Ind.Framing
  , callSeed :: Ind.Seed
  , callEnvironment :: Ind.Environment
  }
  deriving stock (Eq, Show, Generic)
  deriving anyclass (NFData)

-- | The call of the unit of Theta a world is at.
callAt :: Housing -> World -> Call
callAt hs w =
  Call
    (Ind.paramsPlatform q)
    (renderFraming (framingOf w))
    (Ind.paramsSeed q)
    (Ind.paramsEnvironment q)
  where
    q = individual hs

-- | One unit of Theta, given the text the individual wrote. The line is stamped at the
-- record's length with the platform's name, as the individual's frame stamps it; the room
-- decides on the text; an accepted text steps the header and is answered by the memory's
-- toolkit; the trace and the record take the iteration and the line whatever the decision.
-- Nothing here depends on how the text was written, so a world is a function of the world it
-- started from and the texts written since.
stepWith :: Housing -> Text -> World -> World
stepWith hs t w = case d of
  Manual.Refused -> w'
  Manual.Accepted ->
    w'
      { header = Manual.step (roomManual hs) (header w) t
      , memory = R.arrowMap (R.apply (memoryKit (vocab hs) (memoryCtx hs)) t) (memory w)
      }
  where
    q = individual hs
    ln = Rec.Line (Ind.platformName (Ind.paramsPlatform q)) (length (record w)) Rec.Self t
    d = Manual.decide (roomManual hs) (header w) t
    w' = w {roomTrace = roomTrace w ++ [Manual.Iteration t d], record = record w ++ [ln]}

-- | One unit of Theta with the housing's own hydration, which is pure: the text is what the
-- hydration writes for the call of the unit.
stepWorld :: Housing -> World -> World
stepWorld hs w = stepWith hs (Ind.hydrate (Ind.paramsHydration (individual hs)) p f s e) w
  where
    Call p f s e = callAt hs w

-- | The outer frame of the composition: the step of the world under the housing's hydration.
frameOf :: Housing -> R.OuterFrame World
frameOf hs = R.OuterFrame (stepWorld hs)

-- | The world rebuilt from a world and the texts written since, in order.
replayRecord :: Housing -> World -> [Text] -> World
replayRecord hs = foldl (flip (stepWith hs))

-- | What one unit of Theta did, read off the world it left.
data Event = Event
  { eventTheta :: Theta
  , eventText :: Text
  , eventLine :: Maybe Line
  , eventDecision :: Manual.Decision
  , eventGap :: Int
  , eventDays :: Int
  , eventInfos :: Int
  , eventWellFormed :: Bool
  , eventRecordOk :: Bool
  , eventFramingSize :: Int
  , eventFits :: Bool
  }
  deriving stock (Eq, Show, Generic)
  deriving anyclass (NFData)

-- | What the unit of Theta numbered @th@ did, read off the world it left.
eventOf :: Housing -> Theta -> World -> Event
eventOf hs th w =
  Event
    { eventTheta = th
    , eventText = t
    , eventLine = L.read (vocab hs) t
    , eventDecision = d
    , eventGap = Manual.gap (roomManual hs) (header w)
    , eventDays = Trace.days (roomManual hs) (roomTrace w)
    , eventInfos = Mem.memoryCount (memory w)
    , eventWellFormed = Mem.wellFormed (memoryCtx hs) (memory w)
    , eventRecordOk = Rec.attributed (record w) && Rec.resolves (record w)
    , eventFramingSize = Room.size fr
    , eventFits = Room.fits contextLimit fr
    }
  where
    (t, d) = case roomTrace w of
      [] -> ([], Manual.Refused)
      its -> let Manual.Iteration p dd = last its in (p, dd)
    fr = framingOf w

-- | The events of the first @n@ units of Theta from a world, under the housing's hydration.
observe :: Housing -> World -> Int -> [Event]
observe hs w0 n = zipWith (eventOf hs) [1 ..] (take n (drop 1 (iterate (stepWorld hs) w0)))
