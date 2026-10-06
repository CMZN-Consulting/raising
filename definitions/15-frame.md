# frame, properly framed, root, raisers, header, right header, quoting frame, path, local frame, active frame, stop line of a frame, fan-in bound, the closing rule

Depends on: memory, trace, housing, framing.

A frame is a tag-marked region of the framing. Frames nest. The manual says which tag of frame may sit inside which.

A framing is properly framed when the whole path from its root to its innermost frame is well-formed. The manual accepts a frame only inside a well-formed frame, so every framing the individual ever reads is properly framed. This is kept by acceptance and checked by replay. It is never argued from the model.

The root is the first frame. The raisers are those who initialize an individual; they author the root and name themselves in it. A header is the text of a frame that sets how the model is to behave inside it. A header may orient: what the frame is, who reads, what is offered, what the forms are. A header may not assert the individual's attitudes: a header that says the individual is motivated, wants, agrees or feels is refused by the manual. A right header for a case is a header under which the model's turn passes that case.

Outside the root sits the housing (12). The housing is not framing. Every text from outside the individual and the manual enters inside a quoting frame with a tag of its own: it is mentioned, never used as framing, and an outside text cannot become a frame.

The path is the frames from the root to the innermost frame that is open; the framing is the path with the serialization around it. The local frame is the innermost frame of the path. The active frame is the frame whose work the local frame serves and to which its result returns: the frame that opened the local frame, or the local frame itself when nothing opened it. A thing in the framing is said to act on a named frame, the local or the active (20).

Each frame has a stop line of its own, a bound on its size, and the nesting has a depth bound. The stop lines along any path and the depth bound sum below the context limit, with a margin (to be proved from the bounds as declared; the margin is measured for the platform). The fan-in bound F is a parameter: no frame holds more than F items at once, each addressed by its header.

The closing rule: a frame in which no progress (17) has been made for W iterations, W the window of 17, is closed, summarized, and handed to the frame that opened it. So no stretch without progress lasts longer than W in one frame (to be proved from the rule). Nothing is claimed about where the model attends inside a frame.
