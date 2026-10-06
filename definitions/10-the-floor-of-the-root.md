# the floor of the root

Depends on: every definition above. Lean: `Raising/Floor.lean` and the witnesses of `Raising/Language.lean`.

Each notion of the root has a candidate that meets it and a candidate that fails it, so that no theorem of the root is vacuous. The meeting column names the Lean witness; the failing column names what is not one of the notion, or, for an object's extension, a candidate outside it. Division here is the quotient rounded down.

| notion                  | meets                                                                       | fails                                                                        |
| ----------------------- | --------------------------------------------------------------------------- | ---------------------------------------------------------------------------- |
| object                  | `Bounded 3`, the naturals at most three: 2 is in its extension              | 4 is not                                                                     |
| instance                | `two`, the candidate 2 of `Bounded 3` with its showing                      | the candidate 4 alone: no showing exists, so no instance has it              |
| arrow                   | `doubling n`, from `Bounded n` to `Bounded (2 * n)`                         | no arrow from `Bounded n` to itself has the successor as its map             |
| meta-object             | `Listed`, the objects with a property listed: `Bounded 3` is a candidate    | the object over the naturals with nothing listed is not                      |
| declaration             | `BoundedDecl`, the bound as parameter, with the floor for every bound       | a family without a floor for some bound is no declaration                    |
| definition              | `Declare BoundedDecl 3`, whose object is `Bounded 3`                        | `BoundedDecl` with its parameter unstated is a declaration, not a definition |
| implementation          | `defineTwo`, the Define arrow carrying `two`                                | no Define arrow carries 4                                                    |
| outer frame             | `halving n`, legal for every bound                                          | the successor step is not legal: `succ_not_legal`                            |
| the burden              | `burden BoundedDecl 3 defineTwo (halving 3) θ`, for every θ                 | without legality the instance leaves after one unit: `burden_needs_legal`    |
| meta-language, language | `declareMetaLanguage [0, 1]` and its language `binary`, with `defineBinary` | data that calls every text well-formed, over the alphabet `[0]`              |
