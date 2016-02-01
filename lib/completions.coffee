fs = require 'fs'

{filter} = require 'fuzzaldrin'
_ = require('lodash')
{Either, IO} = require('monet')

mod = {}

class mod.Context
  constructor: (@nameSpaces, string) ->
    @query = string.split('.').slice(-1)[0]
    @path = string.split('.').slice(0, -1).join('.')



# Context -> [Suggestion]
mod.candidates = (context) ->
  ns = context.nameSpaces
  matchingNs = _.find(context.nameSpaces, (m) ->
    return context.path.startsWith(m.name)
  )

  # handle rootnamespaces
  if context.path == ''
    return _.map(context.nameSpaces, (ns) ->
      return {
        text: ns.name,
        type: 'namespace',
        rightLabel: 'Root Namespace'
      }
    )

  if not matchingNs
    return []

  lookupPath = context.path.replace(matchingNs.name, matchingNs.path)
  lookupPath = lookupPath.replace(/\./g, '/')

  io = mod.parseNameSpace(lookupPath)
  try
    ret = io.run()
  catch error
    ret = []
  return ret

mod.completions = (context) ->
  return filter(mod.candidates(context), context.query, key: 'text')

# string -> IO
mod.parseNameSpace = (path) ->
  return IO((() ->
    candidates = fs.readdirSync(path)
  )).map((entries) ->
    return _.map(entries, (entry) ->
      return {
        type: if fs.lstatSync(path + '/' + entry).isDirectory() then 'package' else 'class',
        text: entry.replace(/\.js$/, ''),
        rightLabel: if fs.lstatSync(path + '/' + entry).isDirectory() then 'Package' else 'Class',
      }
    )
  )

module.exports = mod
