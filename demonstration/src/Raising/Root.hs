-- | The root's maps, as Haskell holds them: the category of objects and arrows, the outer
-- frame as an action of Theta, the tool and the toolkit. The showings stay in the Lean
-- (@Raising/Object.lean@, @Raising/OuterFrame.lean@, @Raising/Tool.lean@): a Haskell arrow
-- is the map without the showing, and a property is a decidable check, so every claim
-- here is in the measured register and none in the proved one.
module Raising.Root
  ( -- * Object, arrow, instance
    Object (..)
  , inExt
  , Arrow (..)
  , arrowId
  , comp
  , applyArrow
  , Instance
  , instanceOf
    -- * The outer frame and Theta
  , OuterFrame (..)
  , run
  , runArrow
    -- * Tool and toolkit
  , Tool (..)
  , Toolkit
  , names
  , find
  , apply
  , ofToolkit
  ) where

import qualified Control.Category as C
import MundusLanguage.Types (Text, Theta, Token)

-- | Mirrors @Raising.Object@: a carrier, here the type @a@, and the exact list of its
-- properties, here decidable checks. What is listed is required in full.
newtype Object a = Object {props :: [a -> Bool]}

-- | Mirrors @Raising.Object.InExt@: a candidate meets every listed property.
inExt :: Object a -> a -> Bool
inExt (Object ps) x = all ($ x) ps

-- | Mirrors @Raising.Arrow@ without its showing: the map alone. That an arrow keeps the
-- extension is checked, not proved, by 'applyArrow'.
newtype Arrow a b = Arrow {arrowMap :: a -> b}

-- | Mirrors @Raising.Arrow.id@ and @Raising.Arrow.comp@; the laws hold definitionally.
instance C.Category Arrow where
  id = Arrow id
  Arrow g . Arrow f = Arrow (g . f)

-- | Mirrors @Raising.Arrow.id@.
arrowId :: Arrow a a
arrowId = C.id

-- | Mirrors @Raising.Arrow.comp@: first @f@, then @g@.
comp :: Arrow a b -> Arrow b c -> Arrow a c
comp f g = g C.. f

-- | Mirrors @Raising.Instance@: a candidate with the showing, here the check that passed.
type Instance a = a

-- | Mirrors the construction of an instance: the candidate when it meets the object, and
-- nothing otherwise.
instanceOf :: Object a -> a -> Maybe (Instance a)
instanceOf o x = if inExt o x then Just x else Nothing

-- | Mirrors @Raising.Arrow.apply@ with the showing replaced by a check on the target.
applyArrow :: Object b -> Arrow a b -> Instance a -> Maybe (Instance b)
applyArrow target (Arrow f) i = instanceOf target (f i)

-- | Mirrors @Raising.OuterFrame@ without its showing: the step alone.
newtype OuterFrame a = OuterFrame {step :: a -> a}

-- | Mirrors @Raising.OuterFrame.run@: the step applied for that many units of Theta.
-- @run f x (a + b) == run f (run f x a) b@ is @Raising.OuterFrame.run_add@.
run :: OuterFrame a -> a -> Theta -> a
run (OuterFrame s) = go
  where
    go x theta
      | theta <= 0 = x
      | otherwise = let y = s x in y `seq` go y (theta - 1)

-- | Mirrors @Raising.OuterFrame.arrow@: the run to a value of Theta as an arrow.
runArrow :: OuterFrame a -> Theta -> Arrow a a
runArrow f theta = Arrow (\x -> run f x theta)

-- | Mirrors @Raising.Tool@: a name and, for each text of arguments, an arrow on the object.
data Tool a = Tool
  { toolName :: Token
  , act :: Text -> Arrow a a
  }

-- | Mirrors @Raising.Toolkit@: a closed collection of tools on one object.
type Toolkit a = [Tool a]

-- | Mirrors @Raising.Toolkit.names@.
names :: Toolkit a -> Text
names = map toolName

-- | Mirrors @Raising.Toolkit.find@: the first tool so named.
find :: Toolkit a -> Token -> Maybe (Tool a)
find kit n = case filter ((== n) . toolName) kit of
  t : _ -> Just t
  [] -> Nothing

-- | Mirrors @Raising.Toolkit.apply@: the named tool's arrow on the arguments, or the
-- identity, the refusal, on an empty call or an unknown name.
apply :: Toolkit a -> Text -> Arrow a a
apply _ [] = arrowId
apply kit (n : args) = maybe arrowId (`act` args) (find kit n)

-- | Mirrors @Raising.OuterFrame.ofToolkit@: the frame of a kit under a calling rule.
ofToolkit :: Toolkit a -> (a -> Text) -> OuterFrame a
ofToolkit kit call = OuterFrame (\x -> arrowMap (apply kit (call x)) x)
