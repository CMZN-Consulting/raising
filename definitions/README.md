# Definitions

The root of raising: fourteen things defined in Lean 4, with one burden proved over them, and nothing else. The Lean is the definition; each file here is the English rendering of its Lean, names the Lean it renders, and is not edited on its own. The kernel is the check: `scripts/check.sh` builds the root, refuses a `sorry` or an axiom in the source, and refuses any theorem that depends on an axiom beyond Lean's own three. On 2026-10-06 the burden and inheritance depend on no axiom at all, and three falsifiers depend on `propext` (recorded, from that script's output).

The files are read in order. A definition uses no word that a later file defines, except by pointing forward to the file that defines it, in parentheses.

## The fourteen, and where each is

| word           | Lean                                          | file |
| -------------- | --------------------------------------------- | ---- |
| Object         | `Raising.Object`                              | 00   |
| `-->`          | `Raising.Arrow`, written `⟶` in Lean          | 01   |
| `[]`           | `Raising.Collection`                          | 02   |
| Token          | `Raising.Token`                               | 02   |
| Instance       | `Raising.Instance`                            | 00   |
| Meta-Object    | `Raising.MetaObject`                          | 03   |
| Theta          | `Raising.Theta`                               | 04   |
| Declaration    | `Raising.Declaration`                         | 05   |
| Definition     | `Raising.Definition`                          | 06   |
| Declare        | `Raising.Declare`                             | 06   |
| Implementation | `Raising.Implementation`                      | 07   |
| Define         | `Raising.Define`                              | 07   |
| Meta-Language  | `Raising.MetaLanguage`, `declareMetaLanguage` | 09   |
| Language       | `Raising.Language`                            | 09   |

Beside them, the words the fourteen need and the root defines with them: carrier, candidate, property, extension, the interpreter (00); identity, composition (01); text (02); level (03); outer frame, legal, run (04); parameter, stated parameters, the floor, resolution (05); the burden, inheritance (08); well-formed, meaning, alphabet, the declaration of languages (09). The floor of the whole root, a meeting and a failing candidate per notion, is 10.

## The two arrows

Declare goes from a collection of stated parameters to one definition. Define goes from one definition to one implementation. Meta-definitions get declared; definitions get implemented. A meta-language is declared from a collection of tokens, and a language is defined from a meta-language.

## The stack

The root is written in Lean 4 and imports nothing. Each level imports from the levels before it.

| level | repository                                                   | written in                                  | holds                                             |
| ----- | ------------------------------------------------------------ | ------------------------------------------- | ------------------------------------------------- |
| root  | `raising`                                                    | Lean 4                                      | the fourteen and the burden; these renderings     |
| 1     | `interface-language`                                         | Lean 4, the interface-language              | the meta-language the declarations are written in |
| 2     | `room`, `individual`, `memory-artifact`                      | the interface-language                      | the three declarations                            |
| 3     | `mundus-language`                                            | the interface-language, the mundus-language | the language of the definitions of mundus         |
| 4     | `mundus-room`, `mundus-individual`, `mundus-memory-artifact` | the mundus-language                         | the definitions of mundus                         |

A framework is the root at full resolution: one definition of each declaration, every parameter stated, with the constraints shown; it inherits the burden by instantiation and proves nothing of its own. Mundus is the first. The levels below the root are not public on 2026-10-06 (recorded) and are linked from the root README when they are.

## What is not here

raising defines the root and nothing else. An individual, a memory, a room, a frame, a day, a battery, the gap, and the paper's terms (the four conditions, the levers, the parallel terms, the retraining game, the regime, the claim) are not defined in this repository: the first group belongs to the component repositories and the second to the yellow paper. An English draft of them was written on 2026-10-06 and is kept in the first author's records, not here.

## How a rendering is written and changed

Each file names the Lean it renders and states the register of every claim it makes: proved, with the theorem's name, or recorded, with the date. A refinement rewrites a rendering without changing what the Lean says; a change of the Lean that changes a statement is a revision and a breaking change of the version. The version is the `version` field of `package.json`, which `lakefile.toml` repeats; there is no changelog file, and the history keeps every legacy text. The twenty draft definitions of 2026-10-03 stand at commit `9e613ae`; the English draft of 2026-10-06 stands in the history of this branch.

The bar for an English rendering is ten flags: a literal that is neither a parameter nor forced; a word neither basic English nor defined before its use; a cycle in dependencies; nothing that meets it or nothing that fails it; a claim without its register; two readers who did not write it classifying one candidate differently; a reference outside this repository without a citation; two names for one concept or one name for two; a word that asserts in place of structure; a shorter version that does the same. The sixth is the heart of it. On 2026-10-06 two readers who did not write the renderings classified eighteen candidates against them, each without sight of the other: they agreed on every candidate, and both left the same one undecided, whether the number five is a unit of Theta, and both named the same loose sentences (the no-choice clause of 05 without its test, a language in 09 named without its showing, Declare and Define called arrows without saying in which sense). The renderings were refined for each of these the same day, and the refined text has not had a second read (recorded).

## Words this repository does not use

- "undefinable": a parameter is stated, or it is the interface-language's matter.
- "proved", of anything the Lean kernel did not check.
- any sentence that says how an individual will act.
- "axiom", for a constraint: a constraint is shown, and the only axioms are Lean's three.
