import Raising.OuterFrame

/-!
# The floor of the root: witnesses and falsifiers

Each notion of the root has a candidate that meets it and a candidate that fails it, so that
no theorem above is vacuous. A step that leaves the extension is not legal, and the burden
does not hold of it: that is the falsifier of the burden's hypothesis.
-/

namespace Raising

/-- An object over the naturals: the candidates at most `n`. -/
@[reducible] def Bounded (n : Nat) : Object.{0} := ⟨Nat, [⟨fun x => x ≤ n⟩]⟩

/-- What its extension is, read off the one listed property. -/
theorem Bounded.inExt_iff (n x : Nat) : (Bounded n).InExt x ↔ x ≤ n := by
  constructor
  · intro h
    exact h _ (List.Mem.head _)
  · intro h pr hpr
    cases hpr with
    | head => exact h
    | tail _ h' => cases h'

/-- A candidate in the extension, with the showing. -/
example : (Bounded 3).InExt 2 := (Bounded.inExt_iff 3 2).mpr (by decide)

/-- A candidate outside it. -/
example : ¬ (Bounded 3).InExt 4 := fun h => absurd ((Bounded.inExt_iff 3 4).mp h) (by decide)

/-- An instance of the object. -/
def two : Instance (Bounded 3) := ⟨2, (Bounded.inExt_iff 3 2).mpr (by decide)⟩

/-- A declaration over the bound: the parameter is the bound, and the floor is shown for
every fill. -/
@[reducible] def BoundedDecl : Declaration.{0, 0} where
  Params := Nat
  body := Bounded
  meets := fun n => ⟨0, (Bounded.inExt_iff n 0).mpr (Nat.zero_le n)⟩
  fails := fun n => ⟨n + 1, fun h => Nat.not_succ_le_self n ((Bounded.inExt_iff n (n + 1)).mp h)⟩

/-- Declare picks the definition out of the family. -/
example : (Declare BoundedDecl 3).object = Bounded 3 := rfl

/-- One Define arrow of that definition. -/
def defineTwo : Define (Declare BoundedDecl 3) := ⟨two⟩

/-- A legal outer frame: halving keeps every bound. -/
def halving (n : Nat) : OuterFrame (Bounded n) where
  step := fun x => x / 2
  legal := fun x hx =>
    (Bounded.inExt_iff n (x / 2)).mpr
      (Nat.le_trans (Nat.div_le_self x 2) ((Bounded.inExt_iff n x).mp hx))

/-- The burden, instantiated: two, halved for any number of units of Theta, stays at most
three. -/
example (θ : Theta) : (Bounded 3).InExt ((halving 3).run 2 θ) :=
  burden BoundedDecl 3 defineTwo (halving 3) θ

/-- Falsifier of legality: the successor step leaves the extension, so it is not legal and
builds no outer frame. -/
theorem succ_not_legal (n : Nat) :
    ¬ ∀ x : Nat, (Bounded n).InExt x → (Bounded n).InExt (x + 1) :=
  fun h => Nat.not_succ_le_self n
    ((Bounded.inExt_iff n (n + 1)).mp (h n ((Bounded.inExt_iff n n).mpr (Nat.le_refl n))))

/-- Running a step without the showing of legality. -/
def runRaw (step : Nat → Nat) (x : Nat) : Theta → Nat
  | 0 => x
  | θ + 1 => step (runRaw step x θ)

/-- Falsifier of the burden without its hypothesis: under the successor step the instance
leaves the extension after one unit of Theta. -/
theorem burden_needs_legal : ¬ (Bounded 0).InExt (runRaw Nat.succ 0 1) :=
  fun h => Nat.not_succ_le_zero 0 ((Bounded.inExt_iff 0 1).mp h)

/-- A meta-object: the objects with at least one property listed. -/
def Listed : MetaObject.{0} := ⟨[⟨fun O => 0 < O.props.length⟩]⟩

/-- An object that is a candidate of it. -/
example : Listed.toObject.InExt (Bounded 3) := fun pr hpr => by
  cases hpr with
  | head => exact Nat.zero_lt_succ 0
  | tail _ h => cases h

/-- An object that is not. -/
example : ¬ Listed.toObject.InExt ⟨Nat, []⟩ :=
  fun h => Nat.lt_irrefl 0 (h _ (List.Mem.head _))

/-- An arrow between two objects, with its showing: doubling the bound. -/
def doubling (n : Nat) : Bounded n ⟶ Bounded (2 * n) where
  map := fun x => 2 * x
  keeps := fun x hx =>
    (Bounded.inExt_iff (2 * n) (2 * x)).mpr
      (Nat.mul_le_mul_left 2 ((Bounded.inExt_iff n x).mp hx))

/-- A map that is no arrow: the successor does not keep the extension. -/
theorem succ_no_arrow (n : Nat) : ¬ ∃ f : Bounded n ⟶ Bounded n, f.map = Nat.succ :=
  fun ⟨f, hf⟩ => succ_not_legal n (fun x hx => by
    have hk := f.keeps x hx
    rw [hf] at hk
    exact hk)

end Raising
