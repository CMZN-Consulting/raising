# the floor, declarability, declared, defined

Depends on: object, status, definition.

The floor of an object is a pair of candidates shown: one that meets every constraint, and one that fails at least one.

An object is declarable when four things hold. Every meta-variable has a status. Every deferred meta-variable names what it waits on, and the graph of waits has no cycle. Every open meta-variable has one fill shown. For the filled part, the floor is shown.

The floor is what makes an object an object of this framework. An object that nothing could fail is an always-true statement, and an always-true statement is not admitted. An object that nothing could meet is empty, and a claim over an empty object says nothing.

A declarable object with a meta-variable deferred or open is declared. A declarable object with every meta-variable filled is defined. The two words are statuses of one object and nothing else.
