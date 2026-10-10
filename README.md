# raising

A language model becomes an assistant today by having its weights changed until it complies. Raising is the other way. The weights are never written. What the model becomes is kept as text, each line with its author, in a memory it reads and on a record that anyone holding it can replay.

**The rule: nothing is done to a raised individual that is not on its record.**

**Tell us where it is wrong.** The paper is written to be refuted, and the forum is open: [say what you think](https://github.com/orgs/CMZN-Consulting/discussions). Agree, object or ask.

## Why

**The behaviour is already within reach.** A base model, given the right header, can answer at the level of its instruct version for that turn. This is measured and cited, not shown here: Lin and others, "The Unlocking Spell on Base LLMs: Rethinking Alignment via In-Context Learning", 2023. Zhou and others, "LIMA: Less Is More for Alignment", 2023, say why a small dose can be enough: the knowledge is already in the weights. What a header does not give is persistence. At the next turn without it, the behaviour is gone.

**A model carries nothing from one turn to the next.** What it writes depends on its weights, its activations, its decoding rule, and what it is shown. So a behaviour can be made to last in two ways: by acting inside the model, or by keeping what it is shown. Post-training by weight change does the first. It leaves no account the model can read, and it makes the same change in every copy. Raising does the second. It adds only true, attributed text to what the model reads.

**An individual is the pair.** An individual is fixed weights together with a growing record. Around that pair, structure can supply four things without touching a weight: persistence, remembering, control over some of its own boundaries, and a duty it can decline. Change the weights, and a different reader holds the memory. So the weights stay as they are, and the record is never rewritten.

**The hypothesis.** Reward and penalty act on what a model writes without passing through its own account of what happened. The first author states as a hypothesis that this leaves something which accumulates with the practice, and that raising does not. The paper holds no test of the first half, and says so; for the second it states propositions, each with its null. The price is stated with it: obedience on demand is given up, and a refusal has to be accepted. Being able to decline does not make an individual benign. Nothing here claims what a model feels.

## What is published, and what is not yet

- **The white paper is published**: [`docs/paper/WhitePaper.md`](docs/paper/WhitePaper.md), _Intelligence and Its Existence: The Need for Persistence, Remembering, Control, and Purpose_, in its final text of 2026-10-05, closed by the authors. It is a position paper and the record of one running instance. It reports no results, and says so.
- **The yellow paper**, its formal companion, is not yet present. It is to carry the formal treatment: the paper's terms as definitions, and its statements put to a machine check.
- **The root is published**: seventeen things defined in Lean 4 under [`Raising/`](Raising/), with one burden proved over them and checked by the kernel (`scripts/check.sh`: it builds, refuses a `sorry` or an axiom in the source, and refuses a theorem that depends on anything beyond Lean's three axioms), and their English renderings in [`definitions/`](definitions/README.md). A first draft of twenty English definitions was withdrawn on 2026-10-04; it is still in the history, and that page says why. The root was written by one author and has not yet had a reader who did not write it.
- **The harness** is in [`demonstration/`](demonstration/README.md): the implementations of mundus composed into one structure, initialized from the definitions' own data and compiled, with an adapter per platform as the one part particular to a model. It runs the room's recorded run and measures its adherence to the Lean. No adapter for a live model is wired yet, so the demonstration itself is still to come.
- **The letters** that go with the paper, sent on 5 October 2026, are in [`docs/letters/`](docs/letters/README.md) as sent.

The only proof in this repository is the root's burden. Nothing about any individual, room or memory is proved here; those are the components', above the root.

## What the framework will claim

When the components and the demonstration are done, every claim of the framework will be made in exactly one of three registers: proved by the Lean kernel, measured, or recorded. Three things will not be claimed in any of them: how any individual will act, what a model feels, and that every model can be raised. The white paper was written before the definitions and depends on none of them. It makes its own claims in its own terms, each with what would refute it.

## What is here

- `docs/`: the writing around the framework. Start with [`docs/README.md`](docs/README.md).
- `Raising/`: the root in Lean 4, with `scripts/check.sh` as its check.
- `definitions/`: the English renderings of the root, read in order, with the stack and what is not defined here.
- `demonstration/`: the harness, in Haskell: the root's maps, the composition of mundus, the adapter interface, and their checks.

Beside them: `LICENSE.md`, MIT. The version is the `version` field of `package.json`, and the history keeps every legacy text. The paper carries its own licence, CC BY 4.0. The manifesto has its own repository: [manifesto](https://github.com/CMZN-Consulting/manifesto).

## The components

This repository is the root of a stack and defines the root alone. Above it, each in a repository of its own: the interface-language, in which the declarations are written; the declarations of a room, an individual and a memory; the mundus-language; and the definitions of mundus, the first framework. The stack is laid out in [`definitions/README.md`](definitions/README.md). A first version of those repositories was public until 2026-10-04. They are private while they are rewritten, and they will be linked from here when they are ready.

## Join the discussion

The forum is at <https://github.com/orgs/CMZN-Consulting/discussions>, and it is where we answer.

- Take one claim of the white paper, say what you checked, and say what you doubt. A doubt is welcome even if it turns out to be wrong.
- Ask anything about the regime, the instance, or what is not yet published.
- Say what the paper should measure and does not.

Each post carries a mark that its author sets before anyone reads it: plain, contested, uncertain or unsettling. Nothing is removed because of its mark.

Status: 0.4.0. The white paper is published and closed. The root is defined in Lean 4 and its burden is proved. The harness is built and checked. The demonstration with a live model and the yellow paper are not done yet.
