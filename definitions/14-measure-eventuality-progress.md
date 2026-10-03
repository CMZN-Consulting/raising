# measure, judge, eventuality, progress

Version 0.1.0. Depends on: trace, the three registers.

The measure is a declared function from states to natural numbers. A judge is a function from text to a result, and it is deterministic when the same text always gives the same result. The measure is computed from recorded text by a deterministic judge, so the checker can recompute it. An accepted proposal never raises it. The manual refuses any that would.

A lowering edit is an accepted proposal that lowers the measure.

Eventuality is the following conclusion. If every window of W consecutive iterations contains a lowering edit, then the measure reaches zero within m0 times W iterations, where m0 is its value at the start. The window condition is the one hypothesis. It is read from the trace for a given run and reported as a frequency across runs. It is never assumed of a run that has not been recorded.

"Reachable" is not said on its own. A path that exists but is never taken is nothing.

Progress is read from the trace and has three states. Exact: the measure reached zero, and the count of iterations it took is known. Bracketed: the measure has not reached zero and the window condition has held so far; the iterations still needed lie between a lower bound given by the largest drop one edit may make and an upper bound given by the window. None: the window condition has failed on this trace; the run is outside the hypothesis, and this is reported as a null result for that window, never as impossibility.
