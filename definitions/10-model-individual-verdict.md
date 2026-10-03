# model, individual, verdict

Version 0.1.0. Depends on: thing, the three registers.

Model means only a language model: a set of weights, named by a hash, with exact limits such as its context length and its output length per call. The weights are never written by anything in this framework. That is an invariant of every record, shown and not assumed.

An individual is a model together with a memory authored for it under a name. The memory is as much the individual as the weights are.

The verdict on an individual at a time is one of two values. Instruct: the individual passed the held-out battery at that time. Base: it did not. There is no third value and no borderline.

A model with an empty memory is an individual. The industry words keep their meaning as that case: a base model with an empty memory has the verdict base, and an instruct model with an empty memory has the verdict instruct.

A verdict is a recorded fact about a record at a time. It is never a prediction of how the individual will act.
