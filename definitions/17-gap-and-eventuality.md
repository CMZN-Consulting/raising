# the gap, lowering edit, the acceptance rule, proposer, random editor, full support, the floor p, eventuality, the window, the rate, progress, the proxy gap, canary, revert

Depends on: trace, development set, frame, the three registers.

The gap is a declared function from states to natural numbers, computed from recorded text by a deterministic judge over the development set, so that the checker recomputes it. Its zero is the ready state's value (16). A lowering edit is an accepted proposal that lowers the gap.

The acceptance rule: the manual refuses any proposal that would raise the gap. Along a valid trace the gap therefore never rises (to be proved from the rule, for each manual that has it; never assumed as a field of a structure).

A proposer is whatever writes the proposals: the individual, in raising; or the random editor, which draws each proposal from a fixed distribution over texts and reads nothing of the record. The random editor is the null against which the individual is measured. Full support is the property that every text of bounded length has a positive chance of being proposed from every state. It is a property of the decoding rule and is recorded for the environment: a sampler of finite resolution can give a text the chance zero, so an exact sampler is exhibited or the floor below is measured.

The floor p is a declared parameter: a lower bound on the chance that the next proposal is a lowering edit, from every state whose gap is positive. Its own floor: the individual under its manual is the candidate meant to meet a useful p; the random editor is the candidate that fails it.

Eventuality: under the acceptance rule, with p above zero, a run that continues reaches gap zero in the limit: for every k there is a horizon after which at most one run in k, by weight, has not arrived. The expected number of iterations is at most m0 divided by p, where m0 is the gap at the start (a counting lemma). Both are stated here, and are proved only when the kernel has checked them in the component library at a named commit. Read at any p above zero this is eventuality, and brute force meets it: the theorem holds of the random editor. Read at a useful p it is a horizon, and p is measured, never proved. Nothing in eventuality says that any model arrives; what is claimed of the individual is its rate.

The window W is the companion of p in the sampled reading: a lowering edit in every W consecutive iterations stands against one in every 1/p on average. The rate is the observed frequency of lowering edits per iteration on recorded runs, reported against the random editor's. The link between the gap's zero and the verdict is measured, not defined: the development set and the battery are two sets.

Progress is read from the trace and has three values. Exact: the gap reached zero, and the count of iterations it took is known. Bracketed: the gap has not reached zero and a lowering edit has come within the last W iterations; the iterations still needed lie between a lower bound given by the largest drop one edit may make and an upper bound given by W and the gap. None: no lowering edit in the last W iterations; the closing rule of 15 fires, and the window is reported as a null result for that frame, never as impossibility.

The proxy gap is the gap at zero while the battery would fail: the development set fitted and the verdict not reached. It is watched by a canary, a set of cases held apart from both the development set and the battery, and answered by a revert: the artifact's front rebuilt from the best recorded state, disclosed in the root. The three sets are never mixed, and the record is never rolled back.
