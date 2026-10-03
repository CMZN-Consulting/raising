# raising

Version 0.1.0. Depends on: room, trace, measure, verdict.

Raising is the iteration of the room's step from an initialized individual.

Raising is defined by its result and its invariant, never by its mechanism. The result is the verdict moving from base to instruct. The invariant is that the weights are never written. Because the invariant says nothing about how, a process that changes no weights can be a raising.

Raising is not a declaration. It has no constraints of its own, no repository of its own and no witnesses of its own. Every property it has is inherited from the individual, the room and the memory.

Raising stands as an alternative to post-training by weight change for one purpose: obtaining the verdict instruct. Post-training by weight change means every method that changes the weights of a fixed base model, other than continued self-supervised pretraining: supervised fine-tuning, reinforcement learning from human or AI feedback, direct preference optimization and its family, reinforcement learning from verifiable rewards, and distillation into the student.
