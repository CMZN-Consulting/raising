# implementation, Define

Depends on: definition, instance. Lean: `Raising.Implementation`, `Raising.Define`, in `Raising/Declaration.lean`.

An implementation of a definition is an instance of the definition's object: a realized candidate adhering to the specification, with every constraint shown.

Define is the arrow from one definition to one implementation, in the plain sense of 06 and not the arrow of 01. A Define arrow is a realization of the definition, and its showing is that the realization adheres to the definition: checked by the gate where the implementation is Lean, and by replay where it is a run. Two implementations of one definition are two Define arrows, each named by what realizes it.

Every definition has a Define arrow: the meeting candidate of its declaration's floor is one (proved: `Raising.Define.exists`).

Declare and Define compose: from a collection of stated parameters to a definition, and from that definition to an implementation. What is shown of a declaration holds of every definition that Declare picks out of it, and of every implementation that Define makes from those. That is what lets a burden be stated once (08).
