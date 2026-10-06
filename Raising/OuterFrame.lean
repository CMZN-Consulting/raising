import Raising.Declaration

/-!
# The Outer-Frame and the burden

The outer frame is the environment that runs the simulation: it runs an implementation over
Theta, and Theta is its clock. It is aligned to an object and given from outside it: its step
is legal when it keeps the object's extension, which is the one thing the frame shows. The
frame reaches the inside only by its step, and the inside reaches the frame only by a call
(`Raising/Tool.lean`).
The burden is then stated once, over every declaration, every collection of stated
parameters, every Define arrow and every legal outer frame: the implementation keeps every
constraint of the declaration at every Theta. A framework at full resolution inherits it by
instantiation and proves nothing of its own.
-/

namespace Raising

universe u v

/-- An Outer-Frame aligned to an object: a step on candidates that keeps the extension. The
environment that runs the simulation, as the object sees it. -/
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

/-- Theta acts: running for `a` units and then for `b` is running for `a + b`. The outer frame
is an action of its clock on the candidates. -/
theorem OuterFrame.run_add {O : Object.{u}} (F : OuterFrame O) (x : O.Carrier) (a b : Theta) :
    F.run x (a + b) = F.run (F.run x a) b := by
  induction b with
  | zero => rfl
  | succ b ih =>
    show F.step (F.run x (a + b)) = F.step (F.run (F.run x a) b)
    rw [ih]

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
