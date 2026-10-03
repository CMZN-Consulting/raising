# status, schema

Version 0.1.0. Depends on: meta-variable.

Every meta-variable of a meta-thing has exactly one of three statuses.

Filled: a definition supplies it.

Deferred: it waits on a named meta-thing that is not yet filled. The graph of such waits has no cycle. The status ends when the named meta-thing is filled.

Open: no single fill is intended. Each fill is a definition in its own right, and at least one fill has been shown. A claim about an open meta-variable is made for every fill at once, which is called a schema, and measured per fill.

A meta-thing is definable when every meta-variable is filled. Otherwise its status is that of its worst meta-variable. There is no fourth status. A meta-thing that no definition could ever meet is not given a status. It is not admitted.
