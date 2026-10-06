# object, extension, arrow, category, point

Depends on: thing, property, the interpreter.

An object is a thing that lists properties, exactly: every property it requires is listed, and nothing unlisted is required. The listed properties are its constraints (03). The extension of an object is the class of candidates that meet every constraint. An object is its list. Two listings of the same properties are one object, and a name for it is a convenience. An object leaves nothing implicit: what is listed is required in full, and what is not listed is not required.

An arrow from an object A to an object B assigns to every candidate in the extension of A a candidate in the extension of B, together with a showing, for each constraint of B, that the assigned candidate meets it. The interpreter checks the showing. Every object has an identity arrow, which assigns each candidate to itself. Two arrows compose when the first ends where the second starts, composition is associative, and the identity is neutral: the objects and arrows of the framework form a category (Mac Lane, _Categories for the Working Mathematician_, second edition, Springer, 1998). What the framework proves, it proves about arrows.

A point of an object is a candidate in its extension together with the showing for every constraint; equivalently, an arrow into the object from an object whose extension holds exactly that one candidate. An implementation (06) is a point.
