import Raising.Declaration

/-!
# Token, Meta-Language, Language

The last three of the fourteen. A token is the unit of text, and a text is a collection of
tokens. The declaration of languages takes an alphabet, a collection of tokens, as its
parameters; Declare takes the alphabet to a Meta-Language, the definition whose candidates
are the languages over that alphabet; Define takes a Meta-Language to a Language, one
implementation of it: which texts are well-formed, and what each means.
-/

namespace Raising

universe u

/-- A Token: the unit of text, named by a number. -/
abbrev Token := Nat

/-- A text: a collection of tokens. -/
abbrev Text := Collection Token

/-- The data of a language: which texts are well-formed, and a meaning for each one. -/
structure LanguageData where
  WellFormed : Text → Prop
  Meaning : Type u
  meaning : (t : Text) → WellFormed t → Meaning

/-- The one constraint of a language over an alphabet: every well-formed text uses only
tokens of the alphabet. -/
def overAlphabet (alphabet : Collection Token) : Property LanguageData.{u} :=
  ⟨fun L => ∀ t, L.WellFormed t → ∀ tok ∈ t, tok ∈ alphabet⟩

/-- A token that is in no given collection: one more than the largest. -/
def fresh (l : Collection Token) : Token := l.foldr (fun a m => max (a + 1) m) 0

theorem lt_fresh (l : Collection Token) : ∀ a ∈ l, a < fresh l := by
  intro a ha
  induction l with
  | nil => cases ha
  | cons b l ih =>
    cases ha with
    | head => exact Nat.lt_of_lt_of_le (Nat.lt_succ_self _) (Nat.le_max_left _ _)
    | tail _ hb => exact Nat.lt_of_lt_of_le (ih hb) (Nat.le_max_right _ _)

theorem fresh_not_mem (l : Collection Token) : fresh l ∉ l :=
  fun h => Nat.lt_irrefl _ (lt_fresh l _ h)

/-- The declaration of languages: its parameters are an alphabet, and the floor is shown for
every alphabet. The language of the empty text alone meets it; a language whose one
well-formed text carries a token outside the alphabet fails it. -/
def LanguageDecl : Declaration.{0, u + 1} where
  Params := Collection Token
  body := fun alphabet => ⟨LanguageData.{u}, [overAlphabet alphabet]⟩
  meets := fun _ =>
    ⟨⟨fun t => t = [], PUnit, fun _ _ => PUnit.unit⟩, fun pr hpr => by
      cases hpr with
      | head =>
        intro t ht tok htok
        subst ht
        cases htok
      | tail _ h => cases h⟩
  fails := fun alphabet =>
    ⟨⟨fun t => t = [fresh alphabet], PUnit, fun _ _ => PUnit.unit⟩, fun h =>
      fresh_not_mem alphabet
        (h (overAlphabet alphabet) (List.Mem.head _) [fresh alphabet] rfl _ (List.Mem.head _))⟩

/-- A Meta-Language: a definition of the declaration of languages, picked out by an
alphabet. Its candidates are the languages over that alphabet. -/
abbrev MetaLanguage := Definition LanguageDecl.{u}

/-- Declare, from a collection of tokens to one Meta-Language. -/
def declareMetaLanguage (alphabet : Collection Token) : MetaLanguage.{u} :=
  Declare LanguageDecl alphabet

/-- A Language: an implementation of a Meta-Language, one specific language over its
alphabet. A Define arrow from the Meta-Language is what makes one. -/
abbrev Language (M : MetaLanguage.{u}) := Implementation M

/-- A witness: over the alphabet of two tokens, the language of texts that use them, each
text meaning its length. -/
def binary : Language (declareMetaLanguage.{0} [0, 1]) :=
  ⟨⟨fun t => ∀ tok ∈ t, tok ∈ [0, 1], Nat, fun t _ => t.length⟩, fun pr hpr => by
    cases hpr with
    | head => exact fun t ht => ht
    | tail _ h => cases h⟩

/-- One Define arrow from that Meta-Language: the witness above. -/
def defineBinary : Define (declareMetaLanguage.{0} [0, 1]) := ⟨binary⟩

/-- A falsifier: data that calls every text well-formed is no language over `[0]`, since the
text `[1]` uses a token outside the alphabet. -/
theorem everything_not_over_zero :
    ¬ (declareMetaLanguage.{0} [0]).object.InExt ⟨fun _ => True, PUnit, fun _ _ => PUnit.unit⟩ :=
  fun h => by
    have := h (overAlphabet [0]) (List.Mem.head _) [1] trivial 1 (List.Mem.head _)
    cases this with
    | tail _ h' => cases h'

end Raising
