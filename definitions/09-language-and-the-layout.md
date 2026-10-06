# language, meta-language, the interface-language, the gate, hyper-reality, mundus, the mundus-language, the layout

Depends on: object, meta-object, declaration, component.

A language is an object whose candidates are texts, whose one constraint is well-formedness, together with a meaning given to every well-formed text. A language is a meta-language when some of its meanings are objects; it is only a language when all of its meanings are values. The two are told apart by looking at what the meanings are, not by choosing. "Meta-language" is always said of something.

The interface-language is the meta-language of the declarations: Lean 4, restricted by the gate's source rule, together with the library in which the declarations take their formal shape. The gate is the check that admits a Lean source file into the interface-language. It fails a build on a `sorry`, on an axiom beyond Lean's own three (`propext`, `Quot.sound`, `Classical.choice`), on a hypothesis that no proof uses, on a field or a predicate that is always true, and on a dependency outside the pinned set. The gate's rule and the library are not public on 2026-10-06 (recorded); this definition cites them when they are.

A hyper-reality is a definition of the whole: one definition of each of the three declarations, written as data in one language, with the constraints of the composition shown. Mundus is the name of the first hyper-reality. The mundus-language is the language in which the definitions of mundus are data: it is defined in the interface-language, checked by a function of the interface-language, and fitted to its reader, which is a base model. The language an individual reads and writes is only a language: its texts mean lines of a memory and actions of a room, and a new kind of line arrives by a version change made in the meta-language, never by the individual. The forms of the mundus-language are not public on 2026-10-06 (recorded).

The layout is nine repositories in five levels. Each level imports only from the levels above it.

| level | repository                                                 | written in                                      | holds                                                             |
| ----- | ---------------------------------------------------------- | ----------------------------------------------- | ----------------------------------------------------------------- |
| 1     | `raising`                                                  | the interface-language; these definitions in English | the composition, the paper, the demonstration, these definitions |
| 2     | `interface-language`                                       | Lean 4, the interface-language                  | the meta-language and the gate                                    |
| 3     | `room`, `individual`, `memory-artifact`                    | the interface-language                          | the three declarations, each with its floor                       |
| 4     | `mundus-language`                                          | the interface-language, the mundus-language     | the language of the definitions of mundus, defined in itself      |
| 5     | `mundus-room`, `mundus-individual`, `mundus-memory-artifact` | the mundus-language                           | the definitions of mundus                                         |

All nine are repositories of the organisation CMZN-Consulting on GitHub. On 2026-10-06 only `raising` is public (recorded); the others are private while they are rewritten, and are linked from the root README when they are ready.
