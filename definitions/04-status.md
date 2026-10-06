# status, schema, definable

Depends on: meta-variable.

Every meta-variable of an object has exactly one of three statuses.

Filled: a point supplies it.

Deferred: it waits on a named object that is not yet filled. The graph of such waits has no cycle. The status ends when the named object is filled.

Open: no single fill is intended. Each fill is a point in its own right, and at least one fill has been shown. A claim about an open meta-variable is made for every fill at once, which is called a schema, and measured per fill.

The resolution of an object is the share of its meta-variables that are filled. An object is at full resolution, and definable, when every meta-variable is filled. Otherwise its status is that of its worst meta-variable, open being worse than deferred. There is no fourth status. An object that no candidate could ever meet is given no status: it is not admitted (06).
