# definition, meta-definition

Depends on: object, point, status.

A definition of an object is a point of it: a candidate with every meta-variable filled and every constraint shown.

A meta-definition of an object is a point of it with at least one meta-variable deferred or open: every constraint that does not depend on the unfilled part is shown, and the unfilled part is named with its status. A meta-definition is an arrow into the object from the object of its unfilled part.

Several definitions of one object may exist. A definition is a fill, not the fill.

The word is the framework's own and not Lean's `def`. The files in this directory are definitions in the English register of the framework's words. They become definitions in this sense when a word's object has a Lean form and the English is its rendering (25).
