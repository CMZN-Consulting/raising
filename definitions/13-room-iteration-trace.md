# room, iteration, trace

Version 0.1.0. Depends on: individual, memory, frame.

A room is the environment that houses an individual. It offers every action its grounds allow and forbids only what the invariants need: the weights, the authorship of lines, the append-only record. A room evaluates an action by a defined evaluator over declared actions, never by running text as a command.

An iteration is one proposal by the individual together with the manual's verdict on it, accepted or refused. Refused proposals count. They are the individual's effort, and hiding them would flatter it.

The trace is the list of iterations, each with its author. The state at any step is the replay of the accepted proposals up to that step. A checker recomputes every verdict and every measure value from the trace alone, without the model. The model is needed to produce a trace, never to check one.

A valid trace is a trace the checker accepts.
