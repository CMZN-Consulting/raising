import Raising.Declaration

/-!
# The outer frame and the burden

The outer frame is what runs an implementation over Theta. It is aligned to an object: its
step is legal when it keeps the object's extension, which is the one thing the frame shows.
The burden is then stated once, over every declaration, every collection of stated
parameters, every Define arrow and every legal outer frame: the implementation keeps every
constraint of the declaration at every Theta. A framework at full resolution inherits it by
instantiation and proves nothing of its own.
-/

namespace Raising

universe u v

/-- An outer frame aligned to an object: a step on candidates that keeps the extension. -/
structure OuterFrame (O : Object.{u}) where
  step : O.Carrier → O.Carrier
  legal : ∀ x, O.InExt x → O.InExt (step x)

/-- Running a candidate for `θ` units of Theta. -/
def OuterFrame.run {O : Object.{u}} (F : OuterFrame O) (x : O.Carrier) : Theta → O.Carrier
  | 0 => x
  | θ + 1 => F.step (F.run x θ)

theorem OuterFrame.run_zero {O : Object.{u}} (F : OuterFrame O) (x : O.Carrier) :
    F.run x 0 = x := rfl

theorem OuterFrame.run_succ {O : Object.{u}} (F : OuterFrame O) (x : O.Carrier) (θ : Theta) :
    F.run x (θ + 1) = F.step (F.run x θ) := rfl

/-- The burden on an object: an instance run by a legal outer frame stays in the extension
at every Theta. -/
theorem OuterFrame.burden {O : Object.{u}} (F : OuterFrame O) (i : Instance O) :
    ∀ θ : Theta, O.InExt (F.run i.val θ)
  | 0 => i.inExt
  | θ + 1 => F.legal _ (F.burden i θ)

/-- The burden of the meta-framework: for every declaration, every collection of stated
parameters, every Define arrow and every legal outer frame, the implementation keeps every
constraint of the declaration at every Theta. -/
theorem burden (D : Declaration.{u, v}) (p : D.Params) (df : Define (Declare D p))
    (F : OuterFrame (Declare D p).object) (θ : Theta) :
    (Declare D p).object.InExt (F.run df.impl.val θ) :=
  F.burden df.impl θ

/-- Inheritance: whatever is shown of a declaration over its extensions holds of every
implementation of every definition declared from it, at every Theta. -/
theorem inherits (D : Declaration.{u, v}) (P : ∀ p : D.Params, (D.body p).Carrier → Prop)
    (h : ∀ p x, (D.body p).InExt x → P p x) (p : D.Params) (df : Define (Declare D p))
    (F : OuterFrame (Declare D p).object) (θ : Theta) : P p (F.run df.impl.val θ) :=
  h p _ (burden D p df F θ)

/-- The run of a legal frame is itself an arrow at every Theta. -/
def OuterFrame.arrow {O : Object.{u}} (F : OuterFrame O) (θ : Theta) : O ⟶ O :=
  ⟨fun x => F.run x θ, fun x hx => F.burden ⟨x, hx⟩ θ⟩

end Raising
