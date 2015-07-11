_ = require('lodash')

mod = {}

class mod.Matcher
  constructor: (@name, @regex) ->

class mod.BaseToken
  constructor: (@name, @value) ->

class mod.Tokenizer

  match: (matchers, instring) ->
    matchedToken = null
    matcher = _.find matchers, (m) ->
      match = instring.match m.regex
      if match == null
        return false
      else
        matchedToken = new mod.BaseToken(m.name, match[0])
        return true

    return matchedToken

  tokenize: (inString, tokens) ->
    me = this

    splitThrough = (string, fn) ->
      if string.length == 0
        return []
      [length, result] = fn string
      console.log 'got string: ', length, string, result
      return [result].concat(splitThrough string.slice(length) , fn)

    tokens = splitThrough 'Ext.define("lier.something", {', (s) ->
      token = me.match(mod.matchers, s)
      return [token.value.length, token]

    console.log 'tokens: ', tokens

mod.matchers = [
   new mod.Matcher 'define', /^Ext\.define/
   new mod.Matcher 'string', /^'[^']*'/
   new mod.Matcher 'string', /^"[^"]*"/
   new mod.Matcher 'objectbracket', /^[{}]/
   new mod.Matcher 'bracket', /^[()]/
   new mod.Matcher 'comma', /^,/
   new mod.Matcher 'any', /^./
]

module.exports = mod
