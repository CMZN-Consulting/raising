# room, grounds, action, evaluator, runtime, iteration, trace

Version 0.1.0. Depends on: individual, memory.

A room is the environment that houses an individual.

A proposal is a line the individual writes for the manual to decide on. An action is a proposal to change the memory or the room. The grounds are the constraints every action and every language of the room must meet. They forbid only what the invariants need: the weights, the authorship of lines, the append-only record. A room offers every action its grounds allow.

An evaluator is a function, defined in the interface-language, that carries out an accepted action. A room carries out an action by its evaluator, never by running text as a command.

The runtime is the program that runs the room. It sends the context to the model, receives the proposal, applies the manual, carries out accepted actions by the evaluator, and writes the trace.

An iteration is one proposal together with the manual's decision on it, accepted or refused. The room's step is one iteration. Refused proposals count. They are the individual's effort, and hiding them would flatter it.

The trace is the list of iterations, each with its author. The state at any step is the replay of the accepted proposals up to that step. A checker recomputes every decision, and every quantity the manual computes, from the trace alone, without the model. The model is needed to produce a trace, never to check one.

A valid trace is a trace the checker confirms: every decision recomputed matches the decision recorded.
