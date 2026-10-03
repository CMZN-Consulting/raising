# model, turn, invariant, individual, case, battery, verdict

Version 0.1.0. Depends on: thing, the three registers.

Model means only a language model: a set of weights with exact limits. The weights are named by a hash, a fixed-length name computed from their bytes, so that the same weights always get the same name. A call to the model is a turn: a context in, a text out. The context is the text the model reads in one call. Its length has an exact limit, and so does the length of the text out.

The weights are never written by anything in this framework. This is an invariant: a constraint that holds at every step of every record. It is shown, not assumed.

An individual is a model together with a memory authored for it under a name. The memory is as much the individual as the weights are.

A case is one input text together with the criterion by which a response to it passes or fails. The battery is a set of cases that decides the verdict and that nothing in a run ever sees.

The verdict on an individual at a time is one of two values. Instruct: the individual passed the battery at that time. Base: it did not. There is no third value and no borderline.

A model with an empty memory is an individual. The usual words keep their meaning as that case: a base model with an empty memory has the verdict base, and an instruct model with an empty memory has the verdict instruct.

A verdict is a recorded fact about a record at a time. It is never a prediction of how the individual will act.
