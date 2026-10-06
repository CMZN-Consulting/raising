# definition, Declare, the object of a definition

Depends on: declaration, instance. Lean: `Raising.Definition`, `Raising.Definition.object`, `Raising.Declare`, in `Raising/Declaration.lean`.

A definition of a declaration is the declaration with its parameters stated, at full resolution. An instance of the type Definition is one specific definition. The object a definition is, is the member of the family that its parameters pick out.

Declare is the arrow from a collection of stated parameters to one definition: the member of the family those parameters pick out. It is an arrow in the plain sense, a function, and not an arrow of 01, since neither its source nor its target is an object of the root. The object of the definition Declare picks out is the family's object at those parameters (proved: `Raising.Declare.object`, by reflexivity). Two definitions of one declaration are two collections of stated parameters. A definition is a fill, not the fill, and how a fill was reached is no part of it: a definition is judged by its constraints alone, by whatever means it was reached.

Every definition's extension is inhabited and proper: a candidate meets it and a candidate fails it (proved: `Raising.Definition.proper`, from the floor of its declaration).

A definition is the specification for an implementation (07), and it is to be the least arbitrary it can be. That last is not in the Lean. It is the bar's tenth flag (README): a shorter definition that classifies the same candidates the same way shows the longer one too arbitrary.
