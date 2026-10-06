# meta-definition, declaration, Declare, definition, Define, implementation

Depends on: object, point, status, the floor, declarability.

A meta-definition is an object with at least one meta-variable deferred or open. A declaration is a meta-definition that is valid, formed and legal, and that is not arbitrary at all: it makes no choice. Everything in it that could be chosen is a meta-variable, and every literal in it is a parameter or is forced by a burden (09). A declarable object with a meta-variable deferred or open is declared.

Declare is the arrow from a declaration to a definition: it fills the meta-variables of the declaration, with the showing that each fill meets the constraints that speak of it.

A definition is an object at full resolution (04) that is valid, formed and legal: every meta-variable filled, every constraint shown. It is the specification for an implementation, and it is the least arbitrary it can be. A definition must choose, and each of its choices is forced by a burden or is the smallest that lets an implementation exist; a shorter definition that classifies the same candidates the same way, the tenth flag of the bar (25), shows that it was not. A declarable object with every meta-variable filled is defined. Several definitions of one declaration may exist. A definition is a fill, not the fill, and how a fill was reached is no part of it: a definition is judged by its constraints alone, by whatever means it was reached.

Define is the arrow from a definition to an implementation: it realizes the definition, and the showing is that the realization adheres to it, checked by the gate where the implementation is Lean and by replay where it is a run.

An implementation is a point (02) of a definition: a realized candidate adhering to the specification, with every constraint shown. Several implementations of one definition may exist.

The two arrows compose. What is shown of a declaration holds of every definition made from it by Declare, and of every implementation made from those by Define, which is what lets a burden be stated once (09).

The words are the framework's own and not Lean's `def`. The files in this directory are definitions in the English register of the framework's words; a word's text becomes a declaration or a definition in this sense when its object has a Lean form and the English is its rendering (25).
