# Theta, Outer-Frame, legal, run

Depends on: object, instance, arrow. Lean: `Raising.Theta`, `Raising.OuterFrame`, `Raising.OuterFrame.run`, `Raising.OuterFrame.run_add`, `Raising.OuterFrame.arrow`, in `Raising/Object.lean` and `Raising/OuterFrame.lean`.

Theta is the outer frame's time. A value of Theta is a natural number: how many steps the outer frame has taken. One unit of Theta is one step, so the number five is a value of Theta, five steps, and not a unit. Nothing of any individual enters it; what an individual does within one step is the components' matter, not the root's.

The Outer-Frame is the environment that runs the simulation. Aligned to an object, it is a step on the object's candidates that is legal: it keeps the extension, sending every candidate that meets the object to a candidate that meets it, with the showing. The frame is supplied from outside the object, by construction: an object is its carrier and its list of properties, and the step is neither; it comes with the frame. The frame reaches the inside only by its step, and the inside reaches the frame only by a call, which is a tool's matter (11).

Running a candidate to the value θ of Theta applies the step θ times: at zero the candidate is as it was, and each further step applies the step once more (proved: `Raising.OuterFrame.run_zero`, `Raising.OuterFrame.run_succ`, by reflexivity). Running for a units and then for b units is running for a + b units (proved: `Raising.OuterFrame.run_add`): Theta acts on the candidates through the frame, which is what makes Theta the frame's time.

An instance run by a legal outer frame stays in the extension at every value of Theta (proved: `Raising.OuterFrame.burden`). The run to any value of Theta is itself an arrow from the object to itself.
