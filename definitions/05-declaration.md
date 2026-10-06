# parameter, stated parameters, the floor, declaration, resolution

Depends on: object, collection. Lean: `Raising.Declaration`, fields `Params`, `body`, `meets`, `fails`, in `Raising/Declaration.lean`.

A parameter is a part of an object that is left to be stated: a thing of a declared type standing where a thing is required. A collection of stated parameters is one value of the type of all the parameters together, one thing for each parameter; it is a collection in the sense of 02 only when that type is a list, as an alphabet is.

A declaration is a family of objects, one for each collection of stated parameters, together with the floor for every collection: a candidate that meets the object those parameters pick out, and a candidate that fails it. A declaration makes no choice: everything in it that could be chosen is a parameter, and what is not a parameter is forced by a burden. It is not arbitrary at all. The Lean checks none of this sentence; it is the rule for writing a declaration, and the bar's first flag (README) is its test. A choice of witness for the floor is not a choice of the declaration: the floor asks for some candidate that meets and some that fails, and which ones are shown changes nothing of the family.

The floor is a field of the declaration. Whoever builds a declaration shows it, for every fill, and nothing assumes it. An object that nothing could fail would be an always-true statement, and an object that nothing could meet would be empty; neither can be a declaration.

Resolution is the share of a declaration's parameters that are stated. The root states all of them at once, by Declare (06), so a definition is always at full resolution. A parameter that waits on another declaration, or that is left open to several fills at once, is a matter for the interface-language, which extends this root, and not for the root.
