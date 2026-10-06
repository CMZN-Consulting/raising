# the burden, inheritance

Depends on: declaration, definition, implementation, outer frame, Theta. Lean: `Raising.burden`, `Raising.inherits`, in `Raising/OuterFrame.lean`.

The burden of the root is one theorem, stated once over every fill. For every declaration, every collection of stated parameters, every Define arrow of the definition they pick out, every outer frame aligned to that definition's object, and every value of Theta: the implementation, run by the frame for that many units of Theta, keeps every constraint of the declaration (proved: `Raising.burden`; it depends on no axiom).

Inheritance: whatever is shown of a declaration over its extensions holds of every implementation of every definition declared from it, at every value of Theta (proved: `Raising.inherits`). A framework at full resolution therefore inherits the burden by instantiation and proves nothing of its own beyond the constraints its fills show, which the gate checks, so that no fill inherits the burden for free.

The burden needs legality. On the object of the naturals at most zero, the successor step leaves the extension, so it is no outer frame (proved: `Raising.succ_not_legal`), and a candidate stepped by it without that showing leaves the extension after one unit of Theta (proved: `Raising.burden_needs_legal`).
