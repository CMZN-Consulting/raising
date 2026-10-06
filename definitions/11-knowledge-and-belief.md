# statement, leaf, derivation, basis, type, the meet rule, knowledge projection, truthiness, mark, test

Depends on: object, arrow, the three registers.

A statement is a thing that is true or false. A leaf is a statement taken from somewhere other than a derivation: an axiom of the kernel, a measurement, a line of a record, or a value someone holds. A derivation is an arrow from a list of statements, its premises, to one statement, its conclusion, built by rules of inference from leaves and other derivations. Two derivations of one statement are two arrows and are never identified: what a claim rests on is its arrow, not its conclusion. The leaves of a derivation are the leaves it uses; the leaves of a composite are the union of the leaves of its parts.

A basis is a set of leaves accepted as supplying knowledge. The framework's basis is the union of three: the proof basis, the kernel's three axioms through the gate; the measure basis, an instrument with its procedure, its seed and its uncertainty; and the record basis, lines with provenance on an append-only record. These are the three registers (10) read as leaves. Knowledge is only ever relative to a basis.

The type of a derivation in a basis is know when every leaf of it lies in the basis, and believe otherwise. A statement is knowledge in a basis when some derivation of it is know-typed. The meet rule: a derivation is at most as well typed as the weakest of its parts, so one believe-leaf anywhere makes the whole derivation believe-typed. The two readings are orthogonal: adding, removing or replacing leaves outside the basis changes nothing about the leaves inside it.

The knowledge projection of a derivation is the largest part of it all of whose leaves lie in the basis. The conclusions of that part are what the derivation establishes as knowledge, and the remainder of the derivation is what belief carries from there to the conclusion. The projection does not change when the leaves outside the basis change.

The truthiness of a derivation is the set of its leaves outside the basis, each with its test status. Derivations compare by inclusion of these sets. No number is defined, because how much a leaf bears is not counted by number. A statement is knowledge exactly when its best derivation has empty truthiness.

A mark is what a speaker attaches to a sentence that rests on a believe-leaf: the word believed, and the leaf named. The type is a function of the derivation, and the record holds the derivation, so a mark the speaker neglects can be computed and applied by anyone holding the record. This is the manifesto's fifth line (CMZN-Consulting, manifesto, commit `0c41b5a`) made checkable.

A test converts a believe-leaf, in three steps that come in this order and never earlier. A test statement, giving the null, the instrument and the falsifier, enters the record basis before any run. A measurement enters the measure basis after the run. A run rule derives the leaf's statement, or its negation, from the two. The leaf's status is read from which steps exist.

| status         | what exists                                                   |
| -------------- | ------------------------------------------------------------- |
| untested       | the leaf                                                      |
| pre-registered | the leaf and the test statement                               |
| run            | the leaf, the test statement, the measurement and the run rule |
| refuted        | as run, with the run rule landing on the negation             |

A refuted leaf leaves every derivation through it believe-typed. The twelve propositions of the paper are twelve believe-leaves at the pre-registered stage (recorded).
