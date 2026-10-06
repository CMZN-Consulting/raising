# property, candidate, relation, the interpreter

Depends on: thing.

A property is a thing that states a condition on things. A thing the condition is asked of is a candidate. A property with two places, asked of a pair of things, is a relation; nothing further is needed for it.

The interpreter is the function that decides whether a candidate meets a property. It sits outside every thing. A thing never contains the judgement that it meets a property; it contains only the articulation. In Lean 4, the proof assistant at <https://lean-lang.org>, the interpreter is the kernel together with the programs compiled from Lean.

A property is decidable when the interpreter decides it for every candidate. Only decidable properties enter an object (02). A condition that is articulated and not yet decidable is a draft, and is said to be one out loud. A draft is not a failure, and no object lists it.
