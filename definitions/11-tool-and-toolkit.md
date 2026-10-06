# Tool, Toolkit, call, refusal

Depends on: object, arrow, collection, token, text, outer frame, Theta; it points to the burden (08) and to language (09). Lean: `Raising.Tool`, `Raising.Toolkit`, `Raising.Toolkit.names`, `Raising.Toolkit.find`, `Raising.Toolkit.apply`, `Raising.OuterFrame.ofToolkit`, in `Raising/Tool.lean`.

A call is a text. When it is not empty, its first token is the name it calls, and the rest of the text are its arguments.

A tool on an object is a name, which is a token, together with, for each text of arguments, an arrow from the object to itself. The arrows are the tool's whole effect on the object: what a tool does to a candidate, it does by the arrow its arguments pick, and each arrow keeps the extension because it is an arrow (01). A map that leaves the extension is the effect of no tool, for the same reason; on the floor, the successor on a bounded object is no tool's effect (proved: `Raising.succ_no_tool`).

A toolkit is a collection of tools on one object. The names of a kit are the names of its tools, in its order. The tool of a kit under a name is the first so named, and a name not among the kit's names finds no tool (proved: `Raising.Toolkit.find_none_of_not_mem`). A kit is closed in this sense: a call reaches a tool through the kit only if the kit lists it, and what the kit does not list it does not answer.

A kit answers a call. When the call's name is borne by a tool of the kit, the answer is that tool's arrow for the call's arguments (proved: `Raising.Toolkit.apply_found`). When the call is empty, or its name is borne by no tool of the kit, the answer is the identity arrow (proved: `Raising.Toolkit.apply_nil`, `Raising.Toolkit.apply_unknown`). An answer of the second kind is called a refusal. The word names the kit's answering with the identity because no tool answered, not the arrow alone: a tool may itself answer with the identity, and by 01 that is the same arrow. A refusal changes nothing.

A kit together with a calling rule, a map from the candidates of the object to texts, is an outer frame: its step sends a candidate where the kit's answer to that candidate's call sends it. It is an outer frame because every answer of a kit is an arrow and so keeps the extension; the burden on an object (04) therefore holds of it. A candidate whose call is empty, or whose call's name no tool of the kit bears, is sent to itself (proved: `Raising.OuterFrame.ofToolkit_silent`, `Raising.OuterFrame.ofToolkit_refuses`). This is how a candidate asks anything of the outer frame in the root: by a call, through a tool of the kit; and the frame answers through a tool's arrow or with a refusal.

What a call means, what rule gives a candidate's call, and what a tool does beyond the object, where it runs, are not the root's: a language gives texts their meaning (09), and the components state the calling rule.
