# room, proposal, action, the grounds, evaluator, runtime, iteration, state, trace, checker, valid trace, replay, reachable

Depends on: individual, memory, acceptance, language, hydration.

A room is the environment that houses an individual, in the ordinary sense of the word: the manual, the runtime and what they place around it. The environment of 12, the inference path, is one part of it.

A proposal is a line the individual writes for the manual to decide on. An action is a proposal to change the memory or the room. The grounds are the constraints every action and every language of the room must meet. They forbid only what the invariants need: a weight written, a line attributed to one who did not write it, a line of the record rewritten or removed, a line added that is untrue. A room offers every action its grounds allow, and in every state it offers a stop, a null result being a line.

An evaluator is a function, defined in the interface-language, that carries out an accepted action. A room carries out an action by its evaluator, never by running text as a command. The runtime is the program that runs the room: it builds the framing, runs the hydration, receives the proposal, applies the manual, carries out accepted actions by the evaluator, and writes the trace.

An iteration is one proposal together with the manual's decision on it, accepted or refused. The room's step is one iteration. Refused proposals count: they are the individual's effort, and the artifact shows them, because a hydration on an unchanged framing, with the same seed and environment, writes the same text again (to be proved; it follows from the type of the hydration).

The state at any step is the replay of the accepted proposals up to that step. The trace is the list of iterations, each with its author, its seed and its environment. A checker recomputes every decision, and every quantity the manual computes, from the trace alone, without the model. The model is needed to produce a trace, never to check one. A valid trace is a trace the checker confirms: every decision recomputed matches the decision recorded.

"Reachable" is never said bare; it has two readings. Rebuildable: every recorded state can be rebuilt from the record (recorded, and what makes a revert (17) sound). Reachable from a state: another state is reachable from it by actions the manual accepts; a claim about the declared room, proved or refuted per room.
