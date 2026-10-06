# refinement, revision, version, the bar

Depends on: the three registers, declaration, definition, mark.

A definition in this repository starts in English. There is no least arbitrary form of it: what an English sentence means depends on where it is used, on who reads it, and on what that reader has read before. So no definition is ever shown to be least arbitrary. A definition is shown to be too arbitrary, by a structural property, or it clears the bar.

The bar. A definition is acceptable when none of these flags is raised against it.

1. A literal, a number or a name, that is neither a parameter nor forced by a showing.
2. A word that is neither basic English nor defined at or before its first use.
3. A cycle in what it depends on.
4. No thing that meets it, or no thing that fails it, can be shown.
5. A sentence that states a claim without naming its register, or that rests on a believe-leaf without its mark.
6. Two readers who did not write it, given the same candidate things, classify one of them differently, as meeting or as failing.
7. A reference to anything outside this repository without a citation.
8. Two names for one concept, or one name for two.
9. A word that asserts in place of structure: obviously, definitely, clearly, essentially, basically, objectively, naturally, and their kin.
10. A shorter version is shown that raises none of the flags above and classifies the same candidates the same way.

Flags 1, 2, 3, 5, 7, 8 and 9 are read from the text alone and can be checked by a script. Flags 4, 6 and 10 need candidates and readers. Flag 6 is the heart of the bar. Readers need not agree on what a definition means to them, only on what it classifies. Disagreement shows the definition too arbitrary. Agreement shows nothing about meaning, and does not need to.

A refinement rewrites a definition without changing which candidates it classifies as meeting or failing, and raises no flag the legacy did not. A person who did not write either version performs the classification. The author never checks their own refinement: the author is the one reader who cannot see a drift.

Once a definition has a Lean form, its English becomes a rendering of the Lean and is not edited on its own. A Lean-to-Lean refinement is checked by a theorem that the two forms are equivalent. On a Lean term, arbitrariness is counted by a declared measure, the free choices and the primitives used, and a refinement may not increase it. Neither register has a minimum. Both have a bar and a direction.

A revision is a change of meaning made on purpose: some candidate changes class. It owes compatibility, not equivalence: what was recorded under the old version reads under the new, and nothing recorded is lost.

A version is an index in a trace (12); the version of this repository is the index of its state in its history. The one place it is written is the `version` field of `package.json`; a tag on a commit equals the version at that commit, and once the content differs from the last tag the version is greater than that tag's. What a change does to the version: a revision, a removed definition or a changed statement is breaking; a new definition or a new statement is minor; a refinement or a correction of wording is a patch. While the declarations are revisable the version stays below 1.0, and a breaking change raises the minor number. There is no changelog file: the history of this repository keeps every legacy text, and a set of definitions that supersedes an earlier one names the commit that holds the earlier text.
