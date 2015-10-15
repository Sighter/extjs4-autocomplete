_ = require('lodash')

mod = {}

class mod.BaseConstruct
  @regex: /^./
  @kind: 'symbol'

  constructor: (@value) ->
    @name = @constructor.kind

class mod.ClassConstruct extends mod.BaseConstruct
  @regex: /^Ext\.define/
  @closeregex: null
  @kind: 'class'

  constructor: (value, @opening) ->
    super value

  @match: (string) ->
    m = string.match @regex

    if m == null
      return m

    first = (string.indexOf '{') + 1

    findMatchingBracket = (str, startIdx, bracket, closingBracket, stack) ->
      if startIdx >= str.length
        return false
      if stack.length == 0
        return startIdx

      if str[startIdx] == closingBracket
        stack.pop()
        return findMatchingBracket str, startIdx + 1, bracket, closingBracket, stack

      if str[startIdx] == bracket
        stack.push(str[startIdx])
        return findMatchingBracket str, startIdx + 1, bracket, closingBracket, stack

      return findMatchingBracket str, startIdx + 1, bracket, closingBracket, stack

    return findMatchingBracket(string, first, '{', '}', ['{'])


mod.parse = (string, constructList) ->

  consume = (str) ->
    if str.length == 0
      return []

    if str[0] == ' ' or str[0] == '\n'
      return consume(str.slice(1))

    match = mod.ClassConstruct.match(str)
    if match
      console.log str.slice match

    return consume(str.slice(1))

  consume(string)

mod.constructList = [
  mod.ClassConstruct
]

module.exports = mod
