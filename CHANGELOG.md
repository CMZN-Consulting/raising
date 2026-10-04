# Changelog

Every version of this repository. A definition that changes keeps its legacy text here or in the commit named here, and every change is named as a refinement or a revision. See `definitions/19-refinement.md`, which is in the history at commit `9e613ae` since the draft was withdrawn.

## 0.1.0, 2026-10-03, not tagged

Initial scaffold.

- `definitions/00-thing.md` to `definitions/19-refinement.md`: the first definitions, English register, dependency order.
- `definitions/README.md`: how a definition is written, how it changes, and which words are not used.
- `demonstration/`: a placeholder.
- `docs/`: the white paper, `docs/paper/WhitePaper.md`, in its text of 2026-10-04, with an index. Its formal companion and the letters are not yet present. The manifesto has its own repository.
- `LICENSE.md`: MIT, as in the sibling repositories.

Changes within 0.1.0 before release, legacy text in commit `98bb868`:

- Revision of `19-refinement.md` and of `definitions/README.md`: the least-arbitrary minimum is replaced by the bar, ten structural flags. Reason: there is no least arbitrary form of an English sentence, since its meaning depends on where it is used and on who reads it; what can be shown is that a definition is too arbitrary.
- Refinement of the definitions against flags 2, 7 and 8 of the bar: every word is defined at or before its first use; every reference outside this repository carries a citation; "verdict" is reserved for the battery and "decision" for the manual; the checker confirms a trace rather than accepting it. Files 12 and 13 swapped, so that no definition uses a word a later one defines.
- Correction of `08-language-and-meta-language.md`, a refinement: no candidate changes class. The legacy sentence said of the gate: "Its rule is published; it currently lives in the memory-artifact repository at `https://github.com/CMZN-Consulting/memory-artifact`, pending a home of its own." That was false when it was written. That repository holds a scan for axioms beyond Lean's three and no source rule, and the gate's rule is not yet published. The definition now says so. Legacy text in commit `f6f72d4`. That repository is not public on 2026-10-04.
- 2026-10-04, at the publication of the white paper: the first draft of the definitions, `definitions/00-thing.md` to `definitions/19-refinement.md`, is withdrawn from the tree. Reason: the framework is being redefined, and a draft known to be out of date should not stand as the public text. It remains in the history at commit `9e613ae`, and nothing about its having been here is hidden. `demonstration/` is marked as not done yet. The component repositories are no longer linked from the README, because they are not public while they are rewritten.
