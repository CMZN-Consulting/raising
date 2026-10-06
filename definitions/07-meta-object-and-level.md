# meta-object, level

Depends on: object, arrow, declarability, the interpreter.

A meta-object is an object whose candidates are objects. Its constraints are properties of objects: having a floor, being declarable, listing a named constraint, taking a named parameter. A meta-object says what objects must be like, exactly as an object says what things must be like, one level up. The declarable objects are the extension of one meta-object; the declarations (08) are the extension of another, which adds the shape of 08 to declarability.

An object whose candidates are not objects is at level zero. A meta-object whose candidates are objects at level n is at level n plus one. No object is a candidate of itself, and no object stands at two levels: the levels form a tower, not a circle. In Lean the tower is the universe levels. The interpreter sits above every level and is at none.

Arrows between meta-objects are arrows in the sense of 02, with objects as the candidates. The same notion serves at every level, and nothing new is admitted for the higher ones.
