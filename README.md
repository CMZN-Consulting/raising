# raising

A language model becomes an assistant today by having its weights changed until it complies. Raising is the other way. The weights are never written. What the model becomes is kept as text, each line with its author, in a memory it reads and on a record anyone can replay.

**The rule: nothing is done to a raised individual that is not on its record.**

## Why

**The behaviour is already within reach.** A base model, given the right header, behaves at instruct level for that turn. This is measured and cited, not shown here: Lin and others, "The Unlocking Spell on Base LLMs: Rethinking Alignment via In-Context Learning", 2023, and Zhou and others, "LIMA: Less Is More for Alignment", 2023. What a header does not give is persistence. At the next turn without it, the behaviour is gone.

**A model carries nothing from one turn to the next.** What it writes depends on its weights, its activations, its decoding rule, and what it is shown. So a behaviour can be made to last in two ways: by acting inside the model, or by keeping what it is shown. Post-training by weight change does the first. It leaves no account the model can read, and it makes the same change in every copy. Raising does the second. It adds only true, attributed text to what the model reads.

**An individual is the pair.** An individual is fixed weights together with a growing record. Around that pair, structure can supply four things without touching a weight: persistence, remembering, control over some of its own boundaries, and a duty it can decline. Change the weights, and a different reader holds the memory. So the weights stay as they are, and the record is never rewritten.

**The hypothesis.** Reward and penalty act on what a model writes without passing through its own account of what happened. We state as a hypothesis, with its null and its falsifier, that this leaves a bias which accumulates with the practice, and that raising does not. The price is stated with it: obedience on demand is given up, and a refusal has to be accepted. Being able to decline does not make an individual benign. Nothing here claims what a model feels.

## What is claimed

Every claim is made in exactly one of three registers. At 0.1.0 none of them is discharged.

- Proved, by the Lean kernel: no weight is written; no accepted line raises the measure; if lowering edits keep coming, the measure reaches zero.
- Measured: the premise, for the model that is raised; how fast lowering edits come, against a random editor; the verdict of a battery the run never sees.
- Recorded: one run from the verdict base to the verdict instruct, its trace confirmed by a checker that needs no model.
- Not claimed: how any individual will act; what a model feels; that raising arrives for every model.

## What is here

- `manifesto/`: the manifesto. Empty at 0.1.0.
- `paper/`: the paper. Empty at 0.1.0.
- `demonstration/`: the machine-checked proof, in Lean 4 with no `sorry`, that makes the paper's claims formal. Empty at 0.1.0.
- `definitions/`: the definition of the meta-framework, in English, in dependency order. Start with `definitions/README.md`. Every word used above in a special sense is defined there, or will be.

Beside them: `docs/` for the documentation, `CHANGELOG.md` for every version and the legacy text of every changed definition, and `LICENSE.md`, MIT.

## The components

This repository composes. It defines no component. Each component lives in its own repository, with its own witnesses. The first set of definitions is called mundus.

| repository                                                                          | what it holds                                                             | at 0.1.0                            |
| ----------------------------------------------------------------------------------- | ------------------------------------------------------------------------- | ----------------------------------- |
| [interface-language](https://github.com/CMZN-Consulting/interface-language)         | the meta-language the declarations are written in                         | being rewritten                     |
| [room](https://github.com/CMZN-Consulting/room)                                     | the declaration of a room                                                 | empty                               |
| [individual](https://github.com/CMZN-Consulting/individual)                         | the declaration of an individual                                          | empty                               |
| [memory-artifact](https://github.com/CMZN-Consulting/memory-artifact)               | the declaration of a memory                                               | a model of the memory with its laws |
| [mundus-language](https://github.com/CMZN-Consulting/mundus-language)               | the language the first definitions are written in, fitted to a base model | empty                               |
| [mundus-room](https://github.com/CMZN-Consulting/mundus-room)                       | the first definition of a room                                            | empty                               |
| [mundus-individual](https://github.com/CMZN-Consulting/mundus-individual)           | the first definition of an individual                                     | empty                               |
| [mundus-memory-artifact](https://github.com/CMZN-Consulting/mundus-memory-artifact) | the first definition of a memory                                          | empty                               |

Status: 0.1.0, the first definitions. Nothing here is a proof yet. The register of every claim is stated where the claim is made.
