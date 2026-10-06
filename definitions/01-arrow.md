# `-->`, identity, composition, apply

Depends on: object, instance. Lean: `Raising.Arrow`, written `A ⟶ B` in Lean because `--` opens a comment there; `Raising.Arrow.id`, `Raising.Arrow.comp`, `Raising.Arrow.apply`, in `Raising/Object.lean`.

An arrow from an object A to an object B, written A --> B, is a map on candidates that sends every candidate in the extension of A to a candidate in the extension of B, together with the showing. Two arrows with the same map are the same arrow: the showing is not data (proved: `Raising.Arrow.ext`).

Every object has an identity arrow, which sends each candidate to itself. Two arrows compose when the first ends where the second starts. Composition is associative, and the identity is neutral (proved: `Raising.Arrow.id_comp`, `Raising.Arrow.comp_id`, `Raising.Arrow.comp_assoc`, each by reflexivity). The objects and arrows of the framework therefore form a category (Mac Lane, _Categories for the Working Mathematician_, second edition, Springer, 1998). What the framework proves, it proves about arrows.

An arrow applied to an instance of its source gives an instance of its target, with the showing carried along.
