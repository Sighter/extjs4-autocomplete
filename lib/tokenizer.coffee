_ = require('lodash')

mod = {}

class mod.BaseToken
  @regex: /^./
  @kind: 'symbol'

  constructor: (@value) ->
    @name = @constructor.kind

  # match string against the tokens regex and returns
  # the match
  @match: (string) ->
    m = string.match @regex
    ret = if m == null then '' else m[0]


class mod.DefineToken extends mod.BaseToken
  @regex: /^Ext\.define/
  @kind: 'define'

class mod.StringToken extends mod.BaseToken
  @regexes: [/^'[^']*'/,/^"[^"]*"/]
  @kind: 'string'

  @match: (string) ->
    for reg in @regexes
      m = string.match reg
      if m != null
        return m[0]

    return ''

class mod.Tokenizer

  constructor: (@tokenclasses) ->

  # returns the token which is part of @tokenclasses, which
  # matches first on the string and the length of the match
  matchToken: (string) ->
    matchedToken = null
    matchLength = 1

    for tc in @tokenclasses
      match = tc.match(string)
      if match.length > 0
        matchedToken = new tc(match)
        matchLength = match.length
        break

    return [matchLength, matchedToken]

  tokenize: (inString, tokens) ->
    me = this

    splitThrough = (string, fn) ->
      if string.length == 0
        return []
      [length, result] = fn string
      console.log 'got string: ', length, string, result
      return [result].concat(splitThrough string.slice(length) , fn)

    tokens = splitThrough inString, (s) ->
      return me.matchToken(s)

    console.log 'tokens: ', tokens

mod.tokenclasses = [
  mod.StringToken
  mod.DefineToken
  mod.BaseToken
]

module.exports = mod
