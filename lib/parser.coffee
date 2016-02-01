_ = require('lodash')

mod = {}

class mod.BaseConstruct
  @kind: 'baseconstruct'

  constructor: (@value) ->
    @name = @constructor.kind

  # matches a construct against a token list
  #
  # [BaseToken] -> Int
  @match: (tokenList) ->
    return 0

  # build a construct from a definitive match
  #
  # [BaseToken] -> BaseConstruct
  @build: (tokenList) ->
    return new BaseConstruct(null)


class mod.ClassConstruct extends mod.BaseConstruct
  @kind: 'class'

  constructor: (value) ->
    super value
    @leaf = false

  @match: (tokenList) ->
    debugger;
    docbloc = _.first(tokenList) and _.first(tokenList).kind == 'blockcomment'
    offset = if docbloc then 1 else 0
    longEnough = tokenList.length >= 3

    def = if tokenList[offset + 0].kind == 'define' then tokenList[offset + 0] else null
    gua = if tokenList[offset + 1].kind == 'guard' then tokenList[offset + 1] else null
    name = if tokenList[offset + 2].kind == 'string' then tokenList[offset + 2] else null

    if not (def and gua and name)
      return 0
    else
      return offset + 3


mod.constructList = [
  mod.ClassConstruct
]

module.exports = mod
