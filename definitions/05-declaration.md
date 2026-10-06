# parameter, stated parameters, the floor, declaration, resolution

Depends on: object, collection. Lean: `Raising.Declaration`, fields `Params`, `body`, `meets`, `fails`, in `Raising/Declaration.lean`.

A parameter is a part of an object that is left to be stated: a thing of a declared type standing where a thing is required. A collection of stated parameters is one value of that type, one thing for each parameter.

A declaration is a family of objects, one for each collection of stated parameters, together with the floor for every collection: a candidate that meets the object those parameters pick out, and a candidate that fails it. A declaration makes no choice: everything in it that could be chosen is a parameter, and what is not a parameter is forced. It is not arbitrary at all.

The floor is a field of the declaration. Whoever builds a declaration shows it, for every fill, and nothing assumes it. An object that nothing could fail would be an always-true statement, and an object that nothing could meet would be empty; neither can be a declaration.

Resolution is the share of a declaration's parameters that are stated. The root states all of them at once, by Declare (06), so a definition is always at full resolution. A parameter that waits on another declaration, or that is left open to several fills at once, is a matter for the interface-language, which extends this root, and not for the root.
