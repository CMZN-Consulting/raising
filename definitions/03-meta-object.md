# meta-object, level

Depends on: object. Lean: `Raising.MetaObject`, `Raising.MetaObject.toObject`, in `Raising/Object.lean`.

A meta-object is an object whose candidates are objects. It says what objects must be like, exactly as an object says what candidates must be like, one level up. A meta-object is an object at the next level and nothing new: its carrier is the type of objects at the level below (proved: `Raising.MetaObject.carrier`, by reflexivity).

An object at level u has candidates at level u; a meta-object over objects at level u is an object at level u plus one. The levels form a tower, not a circle, and the interpreter is at none of them.
