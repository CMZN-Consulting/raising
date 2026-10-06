# case, judge, development set, greedy, battery, verdict, instruct, base, initialized, the ready state, the premise

Depends on: individual, memory, frame, trace, the three registers.

A case is one input text together with the criterion by which a response to it passes or fails. A judge is a function from text to a result; it is deterministic when the same text always gives the same result.

The development set is the set of cases the manual's acceptance uses to compare two versions of a header. Its judge is deterministic. Its evaluation uses greedy decoding in a fixed environment, so that the output is a function of the platform and the framing alone and acceptance never accepts luck. The outputs on it are recorded as lines of the trace.

An individual is initialized when its root is authored and its memory holds nothing but the manual's first lines.

The battery is a set of cases that decides the verdict. It is held out: nothing in a run ever sees it, so a run cannot train on its test. It names its judge, and where the judge is a person or a model it reports a second judge's agreement on the same recorded responses. It needs its own floor: a known instruct model with an empty memory passes it, and the initialized individual, root included, fails it. Without those two, "instruct" is a word.

The verdict on an individual at a time is one of two values. Instruct: the individual passed the battery at that time. Base: it did not. There is no third value and no borderline. A verdict is a recorded fact about a record at a time. It is never a prediction of how the individual will act. The usual words are the empty-memory case: a base model with an empty memory has the verdict base, and an instruct model with an empty memory has the verdict instruct. "Maturity" is the verdict and has no other sense.

With the platform, the seed and the environment fixed, the verdict at a time is a function of the framing the room shows the model at that time (to be proved, as a congruence over the four inputs of 12).

The ready state is a state of the memory under which the individual's turn scores zero on the gap (17) for the development set. One hand-written ready state is exhibited per platform (recorded). It is the meeting candidate of the development set's floor; the initialized individual is its failing candidate.

The premise: a base model, given a right header, behaves at instruct level for that turn, for that case. It is measured, and it is cited, not shown here: Lin and others, "The Unlocking Spell on Base LLMs: Rethinking Alignment via In-Context Learning", 2023, arXiv 2312.01552; Zhou and others, "LIMA: Less Is More for Alignment", 2023, arXiv 2305.11206. Raising re-measures it for the platform it raises. What the premise does not give is persistence, authorship and generality: the next turn without the header reverts, the header is the raisers', and it is a header per case. Raising supplies those three.
