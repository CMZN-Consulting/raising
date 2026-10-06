# carrier, candidate, property, object, extension, the interpreter, instance

Depends on: nothing. Lean: `Raising.Property`, `Raising.Object`, `Raising.Object.InExt`, `Raising.Instance`, in `Raising/Object.lean`.

A carrier is a type. Its values are candidates. A property is a condition on the candidates of one carrier.

An object is a carrier together with an exact list of properties. What is listed is required in full, and what is not listed is not required. The listed properties are the object's constraints. A candidate is in the extension of an object when it meets every listed property.

The interpreter is what decides whether a candidate meets a property: Lean's kernel, which checks a showing, a proof, and holds no judgement of its own. Nothing the framework writes contains the judgement that it holds. It contains the articulation, and the showing is checked outside it.

An instance of an object is one specific candidate in its extension, together with the showing. It is a point.

An object whose carrier is a type at level u is an object at level u. The levels are Lean's universe levels. No object is a candidate of itself, which the levels enforce and nothing has to state.
