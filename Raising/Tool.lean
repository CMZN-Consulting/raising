import Raising.OuterFrame
import Raising.Language

/-!
# Tool and Toolkit

The outer frame is the environment that runs the simulation, and a tool is how the inside
reaches it. A tool on an object is a name and, for each text of arguments, an arrow from the
object to itself: its whole effect, given from outside the object, with the showing that it
keeps the extension. A toolkit is a closed collection of tools. A call is a text whose first
token names a tool and whose rest are its arguments; a kit answers a call with the named
tool's arrow, and answers a call it has no tool for with the identity, the refusal. A kit and
a calling rule make an outer frame, legal by construction, so the burden holds of it.
-/

namespace Raising

universe u

/-- A Tool on an object: a name, and for each text of arguments a legal step on the object,
an arrow from the object to itself. -/
structure Tool (O : Object.{u}) where
  name : Token
  act : Text → (O ⟶ O)

/-- A Toolkit: a closed collection of tools on one object. -/
abbrev Toolkit (O : Object.{u}) := Collection (Tool O)

namespace Toolkit

variable {O : Object.{u}}

/-- The tool of a kit under a name: the first so named, if any. -/
def find (K : Toolkit O) (n : Token) : Option (Tool O) :=
  K.find? (fun t => t.name == n)

/-- The names a kit answers to, in its order. -/
def names (K : Toolkit O) : Text := K.map (·.name)

/-- A name not among the kit's names finds no tool. -/
theorem find_none_of_not_mem (K : Toolkit O) (n : Token) (h : n ∉ names K) : find K n = none := by
  induction K with
  | nil => rfl
  | cons t K ih =>
    have hne : t.name ≠ n := fun e => h (e ▸ List.Mem.head _)
    have hn : n ∉ names K := fun m => h (List.Mem.tail _ m)
    simp only [find, List.find?_cons]
    rw [show (t.name == n) = false from beq_eq_false_iff_ne.mpr hne]
    exact ih hn

/-- What a kit does with a call: the arrow of the tool the first token names, on the rest of
the text; the identity when the call is empty or names no tool of the kit. -/
def apply (K : Toolkit O) : Text → (O ⟶ O)
  | [] => Arrow.id O
  | n :: args =>
    match find K n with
    | some t => t.act args
    | none => Arrow.id O

theorem apply_nil (K : Toolkit O) : apply K [] = Arrow.id O := rfl

/-- A call that names a tool of the kit is answered by that tool. -/
theorem apply_found (K : Toolkit O) (n : Token) (args : Text) (t : Tool O) (h : find K n = some t) :
    apply K (n :: args) = t.act args := by
  simp [apply, h]

/-- The refusal: a call that names no tool of the kit is answered by the identity. -/
theorem apply_unknown (K : Toolkit O) (n : Token) (args : Text) (h : find K n = none) :
    apply K (n :: args) = Arrow.id O := by
  simp [apply, h]

end Toolkit

/-- The outer frame of a kit under a calling rule: at each unit of Theta the frame reads the
call the candidate makes and applies the kit to it. Legal by construction, since every answer
of the kit is an arrow. -/
def OuterFrame.ofToolkit {O : Object.{u}} (K : Toolkit O) (call : O.Carrier → Text) :
    OuterFrame O where
  step := fun x => (Toolkit.apply K (call x)).map x
  legal := fun x hx => (Toolkit.apply K (call x)).keeps x hx

/-- A candidate whose call names no tool of the kit is left as it is. -/
theorem OuterFrame.ofToolkit_refuses {O : Object.{u}} (K : Toolkit O) (call : O.Carrier → Text)
    (x : O.Carrier) (n : Token) (args : Text) (hc : call x = n :: args) (h : Toolkit.find K n = none) :
    (OuterFrame.ofToolkit K call).step x = x := by
  simp [OuterFrame.ofToolkit, hc, Toolkit.apply_unknown K n args h, Arrow.id]

/-- A candidate that makes no call is left as it is. -/
theorem OuterFrame.ofToolkit_silent {O : Object.{u}} (K : Toolkit O) (call : O.Carrier → Text)
    (x : O.Carrier) (hc : call x = []) : (OuterFrame.ofToolkit K call).step x = x := by
  simp [OuterFrame.ofToolkit, hc, Toolkit.apply_nil, Arrow.id]

end Raising
