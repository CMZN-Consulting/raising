/-!
# The root: Object, `-->` (written `⟶` in Lean), `[]`, Instance, Meta-Object, Theta

The meta-framework of raising defines seventeen things and nothing else. This file holds six
of them. Every word here is the Lean form of the English definition of the same name in
`definitions/`, and the English is a rendering of this file.

Levels are Lean's universe levels: an `Object.{u}` has candidates in `Type u`, and a
`MetaObject.{u}` has candidates that are `Object.{u}`. No object is a candidate of itself,
which the universe levels enforce and which nothing here needs to state.
-/

namespace Raising

universe u v w

/-- A property: a condition on candidates of one carrier. The interpreter, Lean's kernel,
decides whether a candidate meets it by checking the showing. -/
structure Property (α : Type u) where
  pred : α → Prop

/-- An Object: a carrier of candidates and an exact list of the properties it requires. What
is listed is required in full; what is not listed is not required. -/
structure Object where
  Carrier : Type u
  props : List (Property Carrier)

/-- A candidate is in the extension of an object when it meets every listed property. -/
def Object.InExt (O : Object.{u}) (x : O.Carrier) : Prop :=
  ∀ pr ∈ O.props, pr.pred x

/-- An Instance of an object: one specific candidate in its extension, with the showing. A
point. -/
structure Instance (O : Object.{u}) where
  val : O.Carrier
  inExt : O.InExt val

/-- An arrow `A --> B`, written `A ⟶ B` in Lean because `--` opens a comment: a map on
candidates that sends the extension of `A` into the extension of `B`, with the showing. -/
structure Arrow (A : Object.{u}) (B : Object.{v}) where
  map : A.Carrier → B.Carrier
  keeps : ∀ x, A.InExt x → B.InExt (map x)

@[inherit_doc] infixr:25 " ⟶ " => Arrow

namespace Arrow

variable {A : Object.{u}} {B : Object.{v}}

/-- Two arrows with the same map are the same arrow: the showing is not data. -/
theorem ext {f g : A ⟶ B} (h : f.map = g.map) : f = g := by
  cases f; cases g; cases h; rfl

/-- The identity arrow. -/
def id (A : Object.{u}) : A ⟶ A := ⟨fun x => x, fun _ h => h⟩

/-- Composition: first `f`, then `g`. -/
def comp {C : Object.{w}} (f : A ⟶ B) (g : B ⟶ C) : A ⟶ C :=
  ⟨fun x => g.map (f.map x), fun x h => g.keeps _ (f.keeps x h)⟩

theorem id_comp (f : A ⟶ B) : (id A).comp f = f := rfl

theorem comp_id (f : A ⟶ B) : f.comp (id B) = f := rfl

theorem comp_assoc {C : Object.{w}} {D : Object.{w}} (f : A ⟶ B) (g : B ⟶ C) (h : C ⟶ D) :
    (f.comp g).comp h = f.comp (g.comp h) := rfl

/-- An arrow carries an instance of its source to an instance of its target. -/
def apply (f : A ⟶ B) (i : Instance A) : Instance B := ⟨f.map i.val, f.keeps i.val i.inExt⟩

end Arrow

/-- A collection `[]`: an ordered list of things of one type. Lean's list, under the
framework's name, with Lean's `[a, b, c]` notation. -/
abbrev Collection (α : Type u) := List α

/-- A Meta-Object: an object whose candidates are objects, one level up. -/
structure MetaObject where
  props : List (Property Object.{u})

/-- A meta-object is an object at the next level, and nothing new. -/
def MetaObject.toObject (M : MetaObject.{u}) : Object.{u + 1} := ⟨Object.{u}, M.props⟩

/-- The candidates of a meta-object are objects. -/
theorem MetaObject.carrier (M : MetaObject.{u}) : M.toObject.Carrier = Object.{u} := rfl

/-- Theta: the outer frame's time. A value is a natural number, how many steps the frame has
taken; one unit is one step. Nothing of any individual enters it. -/
abbrev Theta := Nat

end Raising
