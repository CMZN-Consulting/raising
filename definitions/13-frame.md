# frame, root, raisers, header, housing

Version 0.1.0. Depends on: memory, trace.

A frame is a tag-marked region of the context the model reads. Frames nest. The manual says which tag of frame may sit inside which.

A context is properly framed when the whole path from its root to its innermost frame is well-formed. The manual accepts a frame only inside a well-formed frame, so every context the model ever reads is properly framed. This is kept by acceptance and checked by replay. It is never argued from the model.

The root is the first frame: the primer. The raisers are those who initialize an individual. They author the root and name themselves in it.

A header is the text of a frame that sets how the model is to behave inside that frame. A right header for a case is a header under which the model's turn passes that case.

Outside the root sit two things that are not frames: the weights, named by hash, and the serialization, the bytes the runtime wraps around the frames, such as a chat template and special tokens. Together they are the housing. The housing is not framing. It is recorded, fixed per version, and the same in every measurement and every run.

Every text from outside the individual and the manual enters inside a quoting frame with a tag of its own. It is mentioned, never used as framing. An outside text cannot become a frame.
