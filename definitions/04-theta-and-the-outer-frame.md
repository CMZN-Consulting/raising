# Theta, outer frame, legal, run

Depends on: object, instance, arrow. Lean: `Raising.Theta`, `Raising.OuterFrame`, `Raising.OuterFrame.run`, `Raising.OuterFrame.arrow`, in `Raising/Object.lean` and `Raising/OuterFrame.lean`.

Theta is the outer frame's unit of time: a natural number that counts the outer frame's steps. Nothing of any individual enters it; what an individual does within a unit of Theta is the components' matter, not the root's.

An outer frame aligned to an object is a step on the object's candidates that is legal: it keeps the extension, sending every candidate that meets the object to a candidate that meets it, with the showing. Running a candidate for θ units of Theta applies the step θ times: zero units leave it as it is, and one more unit applies the step once more (proved: `Raising.OuterFrame.run_zero`, `Raising.OuterFrame.run_succ`, by reflexivity).

An instance run by a legal outer frame stays in the extension at every Theta (proved: `Raising.OuterFrame.burden`). The run for θ units is itself an arrow from the object to itself.
