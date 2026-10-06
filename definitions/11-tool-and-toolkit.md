# Tool, Toolkit, call, refusal

Depends on: object, arrow, collection, token, text, outer frame, Theta. Lean: `Raising.Tool`, `Raising.Toolkit`, `Raising.Toolkit.names`, `Raising.Toolkit.find`, `Raising.Toolkit.apply`, `Raising.OuterFrame.ofToolkit`, in `Raising/Tool.lean`.

A tool on an object is a name, which is a token, together with, for each text of arguments, an arrow from the object to itself. The arrow is the tool's whole effect: what it does is supplied with the tool, from outside the object, and the showing that it keeps the extension is part of being a tool. A map that leaves the extension is the effect of no tool (proved on the floor: `Raising.succ_no_tool`).

A toolkit is a collection of tools on one object. It is closed: the tools it lists are all the tools there are for that object. The names of a kit are the names of its tools, in its order. The tool of a kit under a name is the first so named, and a name not among the kit's names finds no tool (proved: `Raising.Toolkit.find_none_of_not_mem`).

A call is a text. Its first token names a tool, and the rest of the text are the arguments. A kit answers a call with the arrow of the tool the first token names, on the arguments (proved: `Raising.Toolkit.apply_found`). A call that is empty, or whose first token names no tool of the kit, is answered with the identity arrow: the refusal (proved: `Raising.Toolkit.apply_nil`, `Raising.Toolkit.apply_unknown`). A refusal changes nothing, and it is an arrow like every answer.

A kit together with a calling rule, a map from the candidates of the object to texts, makes an outer frame: at each unit of Theta the frame reads the call the candidate makes and applies the kit to it. The frame is legal by construction, since every answer of a kit is an arrow, so the burden holds of it (08). A candidate whose call is empty, or names no tool of the kit, is left as it is (proved: `Raising.OuterFrame.ofToolkit_silent`, `Raising.OuterFrame.ofToolkit_refuses`). This is the one way the inside reaches the outer frame in the root: by a call, through a tool of the kit; and the frame answers through the tool's arrow or not at all.

What a call means, who makes it, and what a tool does outside the object are not the root's: a language gives texts their meaning (09), and the components say what makes a call.
