# well-formed, meaning, alphabet, the declaration of languages, meta-language, language

Depends on: token, text, collection, declaration, definition, implementation. Lean: `Raising.LanguageData`, `Raising.overAlphabet`, `Raising.LanguageDecl`, `Raising.MetaLanguage`, `Raising.declareMetaLanguage`, `Raising.Language`, in `Raising/Language.lean`.

The data of a language is three things: which texts are well-formed; a type of meanings; and a meaning for every well-formed text.

The declaration of languages takes an alphabet, a collection of tokens, as its stated parameters. Its one constraint is that every well-formed text uses only tokens of the alphabet. Its floor is shown for every alphabet: the language whose one well-formed text is the empty text meets it, and a language whose one well-formed text carries a token outside the alphabet fails it. That token is the fresh token of the alphabet, one more than its largest, which is in no alphabet (proved: `Raising.fresh_not_mem`).

A meta-language is a definition of the declaration of languages, picked out by an alphabet. Declare takes a collection of tokens to one meta-language, and the meta-language's candidates are the languages over that alphabet.

A language is an implementation of a meta-language: one specific language over its alphabet, which a Define arrow from the meta-language makes. Over the alphabet of the two tokens 0 and 1, the texts that use only them, each meaning its own length, is a language (`Raising.binary`, with its Define arrow `Raising.defineBinary`). Data that calls every text well-formed is no language over the alphabet of the one token 0, since the text of the one token 1 would be well-formed (proved: `Raising.everything_not_over_zero`).
