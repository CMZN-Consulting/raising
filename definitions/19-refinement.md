# refinement

Version 0.1.0. Depends on: the three registers.

A definition in this repository starts in English. It is written in the fewest words that satisfy, with the fewest free choices. A free choice is a constant or a parameter that no proof needs.

A refinement rewrites a definition with the same meaning and fewer free choices. A person who did not write either version reads both and checks that the meaning is the same. The author never checks their own refinement. The author is the one reader who cannot see a drift.

Once a definition has a Lean form, its English becomes a rendering of the Lean and is not edited on its own. A Lean-to-Lean refinement is checked by a theorem that the two forms are equivalent.

Arbitrariness is counted on a Lean term by a declared measure: the free choices and the primitives used. A refinement may not increase it. On English, a reader judges, and the changelog says so.

A revision is a change of meaning made on purpose. It is a version change, and it owes compatibility, not equivalence: what was recorded under the old version reads under the new, and nothing recorded is lost. The changelog names every change as a refinement or a revision, and keeps the legacy text.
