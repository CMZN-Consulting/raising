# declaration, extension of a declaration, component

Depends on: declarability, meta-object.

A declaration is a declarable object whose candidates are structures of named fields and whose constraints are a list over those fields.

This framework has three declarations: the individual (13), the room (14) and the memory (13). Each lives in a repository of its own, with its own floor, and imports only what sits below it in the layout (09). This repository defines none of them. It composes them. The English definitions of the three stand here until the component's own repository holds them, and are pulled from there, by pin, after that.

An extension of a declaration adds fields or constraints and removes none. Forgetting the added part is an arrow from the extension to the declaration it extends, so every definition of an extension is a definition of the declaration, and whatever is shown of a declaration holds of every extension of it. Dropping a constraint is not an extension.

A component is a declaration together with the repository that holds it and the definitions of it that other repositories hold. The repository named for a declaration holds the declared object and its floor; a repository named for a framework (09) holds a definition of it.
