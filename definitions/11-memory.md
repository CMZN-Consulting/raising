# memory: record, artifact, manual

Version 0.1.0. Depends on: individual.

A memory has two layers and one set of rules. A line is a thing stored in a memory. Every line carries its author.

The record is the complete text of the individual's experience, kept verbatim and append-only. No line is attributed to the individual that the individual did not write. Lines from others, such as a prompt or a message, are kept with their author named. Nothing in the record is ever rewritten or removed.

The artifact is the structured, bounded part of the memory that the individual reads in context. It has a stop line, a bound on its size, so it cannot hold the whole record. What the artifact holds, and how, is the structure the manual gives it.

The manual is the set of rules by which lines are framed, stored and maintained. It is fixed per version. It governs both layers. The individual writes a line; the manual's decision is to accept it or to refuse it; a checker replays every decision. Acceptance is the manual's decision to accept.
