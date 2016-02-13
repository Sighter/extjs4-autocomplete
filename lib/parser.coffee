_ = require('lodash')

mod = {}

class mod.Parser
  parse: (string) ->
    return [{
      remaining: string
      construct: null
    }]

class mod.RegexParser extends mod.Parser
  constructor: (@regex, @name) ->

  parse: (string) ->
    m = string.match(@regex)
    if m
      return [
        remaining: string.slice(m[0].length)
        name: @name
        consumed: m[0]
      ]
    else
      return []

class mod.SymbolParser extends mod.Parser
  constructor: (@symbol, @name) ->

  parse: (string) ->
    if string.length > 0 and string[0] == @symbol
      return [
        remaining: string.slice(1)
        name: @name
        consumed: @symbol
      ]
    else
      return []

class mod.Many extends mod.Parser
  constructor: (@parser) ->

  parse: (string) ->
    result = @parser.parse(string)
    if result.length == 0
      return []
    else
      return result.concat(@parse(result[0].remaining))

class mod.Choice extends mod.Parser
  constructor: (@parsers) ->

  parse: (string) ->
    p = _.find(@parsers, (parser) ->
      return parser.parse(string).length != 0
    )
    if p then p.parse(string) else []

class mod.Choice extends mod.Parser
  constructor: (@parsers) ->

  parse: (string) ->
    p = _.find(@parsers, (parser) ->
      return parser.parse(string).length != 0
    )
    if p then p.parse(string) else []

module.exports = mod
