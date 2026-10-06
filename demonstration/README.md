# Demonstration

The demonstration composes the implementations of mundus into one structure, initializes it from the definitions' own data, and runs it. It is the main demonstration of the framework: the Lean above it holds the definitions and the burden, and this package holds what runs.

## What is here

- `src/Raising/Root.hs`: the root's maps in Haskell. The category of objects and arrows, the outer frame as an action of Theta, the tool and the toolkit, each named after the Lean it mirrors. The showings stay in the Lean: a Haskell arrow is the map without the showing, and a property is a decidable check, so every claim of this package is in the measured register and none in the proved one.
- `src/Demonstration/Mundus.hs`: the composition. One structure holding the language, the memory, the room and the individual of mundus, initialized from the texts the four definitions state (the vocabulary, the knobs, the development set, the platform and the environment), and the loop that runs it: a week of days, each day a framing, a hydration, a text read by the language, answered by the room and the memory, and recorded on the individual's record until the bed.
- `app/Main.hs`: the executable `demonstration`.
- `test/Spec.hs`: the measured adherence. The composed structure, run on the recorded texts of the room's definition, reproduces the values the Lean proves: the decisions of the trace, the gap's arrival at zero, the three days, the record's attribution.

## The implementations it composes

Each repository whose name starts with `mundus-` carries its own implementation beside its Lean definition, under `implementation/`, as a cabal package of the same name. This package names the four as path dependencies in `cabal.project`, checked out beside this repository, as Lake's path dependencies do for the Lean above them. The language package also carries the shared types, because in Haskell a text is read before the memory runs.

| package                  | repository               | mirrors                                              |
| ------------------------ | ------------------------ | ---------------------------------------------------- |
| `mundus-language`        | `mundus-language`        | the reader and printer, the forms line, the alphabet |
| `mundus-memory-artifact` | `mundus-memory-artifact` | the memory, its ten tools, the knobs, the days       |
| `mundus-room`            | `mundus-room`            | the manual, the trace, the framings, the week        |
| `mundus-individual`      | `mundus-individual`      | the platform, the record, the hydration, the status  |

## Build and run

GHC 9.14.1 and cabal 3.18, the desk's pins. The four sibling repositories must be checked out beside this one.

```sh
cabal build all
cabal test all
cabal run demonstration
```

## What the demonstration does not do

It defines no component: every definition is the Lean's, and the Haskell mirrors it by name. The hydration it runs by default is the fill the individual's definition states, which always goes to bed, and the recorded run of the room, replayed; a model adapter that hydrates from a live model is the one deferred meta-variable of the individual's definition and is wired here when it exists.
