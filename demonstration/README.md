# Demonstration

The harness of mundus, compiled. It composes the implementations of mundus into one structure, initializes it from the definitions' own data, and runs it one unit of Theta at a time, with an adapter per platform as the one part that is particular to a model. The Lean above it holds the definitions and the burden; this package holds what runs.

## What is here

- `src/Raising/Root.hs`: the root's maps in Haskell. The category of objects and arrows, the outer frame as an action of Theta, the tool and the toolkit, each named after the Lean it mirrors. The showings stay in the Lean: a Haskell arrow is the map without the showing, and a property is a decidable check, so every claim of this package is in the measured register and none in the proved one.
- `src/Demonstration/Mundus.hs`: the composition. A housing, what the definitions fix, and a world, what a run changes: the room's header and trace, the memory, the individual's record. One unit of Theta takes the text the individual wrote from the framing it reads; the room decides on it; the memory's toolkit, the ten tools and the bed in the root's sense, answers an accepted text; the line is appended to the record whatever the decision. The step is pure given the text, so a world is a function of the world it started from and the texts written since, and the record's texts rebuild it.
- `src/Demonstration/Adapter.hs`: the adapter, the interface a platform must meet.
- `src/Demonstration/Harness.hs`: the harness loop, which gives each unit's call to an adapter, guards the answer and steps the world with it.
- `app/Main.hs`: the executable `harness`.
- `adapter/ReplayAdapter.hs`: the executable `replay-adapter`, the reference adapter in another process. It speaks the wire and replays the room's recorded run, a pure function of the framing it is sent; a model's adapter replaces it.
- `test/Spec.hs`: the measured adherence. Twenty-eight checks: the composition run on the recorded texts of the room's definition reproduces the values the Lean proves of each part (the decisions of the trace, the gap's arrival at zero, the three days, the record's attribution, the memory's invariants at every unit), the root's action law holds of the world's frame, the harness gives the world the pure step gives, in this process and through the reference adapter in another, and the guard refuses what it must.

## The adapter

An adapter is bound to one platform, a series and a version with the hash of their weights, and hydrates it. It is given the call of a unit of Theta, the platform, the framing, the seed and the environment, and answers with the text the model wrote and the hash of the weights it actually ran. It is given nothing else of the harness and returns nothing else: the room, the memory and the record are the harness's, and every tool is run by the harness, so nothing reaches the individual that is not on its record.

The hydration of the individual's definition is a pure function of those four inputs, and it is the one meta-variable that definition leaves deferred, on the model adapter. A real model is pure only when its environment makes it so, so the harness measures purity rather than assuming it:

- **The guard.** A call for another platform is refused, and so is an answer from weights other than the platform's: by the definitions a change of weights is a death.
- **The replay check.** One call is hydrated twice and the two texts compared. Agreement is what earns an environment its `replayed` flag.
- **The record.** A run's texts rebuild its world exactly, so a run can be audited from its record alone.

An adapter runs in this process, as a pure hydration does, or in another process over the wire: one line of numbers each way. A call is the seed, the framing's length and the framing; an answer is the weights' hash, the text's length and the text. The platform and the environment are the adapter's own configuration, checked by the guard and not sent. An adapter for a model is then a small program in whatever language serves the model, beside the server that holds its weights.

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

```text
cabal build all
cabal test all
cabal run harness
cabal run harness -- --units 9 --adapter PATH-OF-REPLAY-ADAPTER
```

`cabal list-bin replay-adapter` prints the path of the reference adapter. With no arguments the harness runs the main demonstration in this process: the room's recorded run, replayed, and then the hydration the individual's definition states, which always goes to bed. With an adapter it first runs the replay check on the first call, then the units asked for.

## What the demonstration does not do

It defines no component: every definition is the Lean's, and the Haskell mirrors it by name. No adapter for a live model is here yet; it is the deferred meta-variable of the individual's definition, and it plugs in as a command given to `--adapter`.
