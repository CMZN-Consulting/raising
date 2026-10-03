# the premise, the development set, the battery

Version 0.1.0. Depends on: frame, verdict, measure.

The premise: a base model, given a right header, behaves at instruct level for that turn, for that case. This is measured, and it is cited from published work, not shown here. Raising re-measures it for the model it raises. What the premise does not give is persistence, authorship and generality: the next turn without the header reverts, the header is the raisers', and it is a header per case. Raising supplies those three.

The development set is the set of cases the manual's acceptance uses to compare two versions of a header. Its judge is a deterministic function of text. Its evaluation uses greedy decoding, so that acceptance never accepts luck. The model's outputs on it are recorded as lines of the trace.

The battery is the set of cases that decides the verdict. It is held out: acceptance never sees it, so a run cannot train on its test. It may use any judge. It needs its own two witnesses: a known instruct model with an empty memory passes it, and the base model with an empty memory fails it. Without those two, "instruct" is a word.

The development set and the battery are two sets. The link between them, that reaching the measure's zero gives the verdict instruct, is measured.
