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

  # this calls match and creates a token if match was successful
  # returns a tuple of match length and token
  @matchCreate: (string) ->
    match = @match(string)
    if match.length > 0
      matchedToken = new @(match)
      matchLength = match.length
      return [matchLength, matchedToken]
    else
      return null


class mod.DefineToken extends mod.BaseToken
  @regex: /^Ext\.define/
  @kind: 'define'

class mod.FunctionToken extends mod.BaseToken
  @regex: /^function/
  @kind: 'function'

class mod.WordToken extends mod.BaseToken
  @regex: /^\w*/
  @kind: 'word'

class mod.StringToken extends mod.BaseToken
  @regexes: [/^'[^']*'/,/^"[^"]*"/]
  @kind: 'string'

  @match: (string) ->
    for reg in @regexes
      m = string.match reg
      if m != null
        return m[0]

    return ''

class mod.GuardToken extends mod.BaseToken
  @openregex: null
  @closeregex: null
  @kind: 'guard'

  constructor: (value, @opening) ->
    super value

  @match: (string) ->
    return ''

  @matchCreate: (string) ->
    openmatch = string.match @openregex
    closematch = string.match @closeregex

    if openmatch
      matchedToken = new @(openmatch[0], true)
      matchLength = openmatch.length
      return [matchLength, matchedToken]
    else if closematch
      matchedToken = new @(closematch[0], false)
      matchLength = closematch.length
      return [matchLength, matchedToken]
    else
      return null

class mod.LiteralBracketToken extends mod.GuardToken
  @openregex: /^{/
  @closeregex: /^}/

class mod.ParenthesesToken extends mod.GuardToken
  @openregex: /^\(/
  @closeregex: /^\)/

class mod.BlockCommentToken extends mod.BaseToken
  @kind: 'blockcomment'

  @matchCreate: (string) ->
    openmatch = string.match /^\/\*/

    if openmatch
      idx = 0
      while idx <= (string.length - 2)
        if string[idx] == '*' and string[idx + 1] == '/'
          slicel = idx + 2
          tok = new @(string.slice(0, slicel))
          return [slicel, tok]
        else
          idx += 1
          continue

    return null

class mod.Tokenizer

  constructor: (@tokenclasses) ->

  # returns the token which is part of @tokenclasses, which
  # matches first on the string and the length of the match
  matchToken: (string) ->
    for tc in @tokenclasses
      result = tc.matchCreate(string)
      if result
        return result

  tokenize: (inString) ->
    me = this
    tokens = []
    workstring = inString

    tokens = while workstring.length > 0
      # skip whitespace
      if workstring[0] == ' ' or workstring[0] == '\n'
        workstring = workstring.slice(1)
        continue

      [l, tok] = me.matchToken(workstring)
      workstring = workstring.slice(l)
      ret = tok

    console.log tokens
    return tokens


mod.tokenclasses = [
  mod.StringToken
  mod.BlockCommentToken
  mod.FunctionToken
  mod.DefineToken
  mod.LiteralBracketToken
  mod.ParenthesesToken
  mod.WordToken
  mod.BaseToken
]

module.exports = mod
