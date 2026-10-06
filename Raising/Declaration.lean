import Raising.Object

/-!
# Declaration, Definition, Declare, Implementation, Define

Five more of the fourteen. A declaration makes no choice: every choice is a parameter, and
the declaration is a family of objects indexed by the collections of stated parameters.
Declare takes one such collection to the definition it picks out. Define takes one
definition to one implementation. The floor is a field of the declaration: whoever builds
one shows it, for every fill, and nothing here assumes it.
-/

namespace Raising

universe u v

/-- A Declaration: the type of collections of stated parameters, the object each collection
picks out, and the floor for every fill: a candidate that meets, a candidate that fails. -/
structure Declaration where
  Params : Type u
  body : Params → Object.{v}
  meets : ∀ p, ∃ x, (body p).InExt x
  fails : ∀ p, ∃ x, ¬ (body p).InExt x

/-- A Definition of a declaration: the declaration with its parameters stated, at full
resolution. An instance of this type is one specific definition. -/
structure Definition (D : Declaration.{u, v}) where
  params : D.Params

/-- The object a definition is: the member of the family its parameters pick out. -/
def Definition.object {D : Declaration.{u, v}} (d : Definition D) : Object.{v} :=
  D.body d.params

/-- Declare: from a collection of stated parameters to one definition. -/
def Declare (D : Declaration.{u, v}) (p : D.Params) : Definition D := ⟨p⟩

theorem Declare.object (D : Declaration.{u, v}) (p : D.Params) :
    (Declare D p).object = D.body p := rfl

/-- An Implementation of a definition: an instance of its object, a realized candidate
adhering to the specification with every constraint shown. -/
abbrev Implementation {D : Declaration.{u, v}} (d : Definition D) := Instance d.object

/-- A Define arrow: from one definition to one implementation. Two implementations of one
definition are two Define arrows. -/
structure Define {D : Declaration.{u, v}} (d : Definition D) where
  impl : Implementation d

/-- The floor is never vacuous: every definition's extension is inhabited and proper. -/
theorem Definition.proper {D : Declaration.{u, v}} (d : Definition D) :
    (∃ x, d.object.InExt x) ∧ (∃ x, ¬ d.object.InExt x) :=
  ⟨D.meets d.params, D.fails d.params⟩

/-- Every definition has a Define arrow: the meeting candidate of the floor is one. -/
theorem Define.exists {D : Declaration.{u, v}} (d : Definition D) : Nonempty (Define d) :=
  match D.meets d.params with
  | ⟨x, hx⟩ => ⟨⟨⟨x, hx⟩⟩⟩

end Raising
