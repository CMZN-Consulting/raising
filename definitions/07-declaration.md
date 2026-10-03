# declaration

Version 0.1.0. Depends on: declarability.

A declaration is a declarable meta-thing whose raw data is a record of named fields and whose conditions are a list of constraints.

This framework has three declarations: the individual, the room, and the memory. Each lives in its own repository, with its own witnesses, and imports only what sits below it. This repository defines none of them. It composes them.

An extension of a declaration adds fields or constraints and removes none. Every definition of an extension is a definition of the declaration it extends. Whatever is shown of a declaration holds of every extension of it.
