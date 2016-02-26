mod = {}

fs = require 'fs'
plib = require 'path'
_ = require 'lodash'

# get the prefix of the cursor in atom editor
#
# editor -> position -> String
mod.getPrefix = (editor, bufferPosition) ->
  # Whatever your prefix regex might be
  regex = /[\w0-9_.-]+$/

  # Get the text for the line up to the triggered buffer position
  line = editor.getTextInRange([[bufferPosition.row, 0], bufferPosition])

  # Match the regex to the line, and return the match
  line.match(regex)?[0] or ''

# find a matching bracket using stack
#
# String -> Int -> Char -> Char -> Array -> Int
mod.findMatchingBracket = (str, startIdx, bracket, closingBracket, stack) ->
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

# given a path and a list of namespaces return a namespace path which matches
#
# Path -> [Namespace] -> String
mod.nameSpacePath = (path, map) ->
  p = _.find(map, (ns) ->
    return path.startsWith(ns.path)
  )
  if p
    normPath = p.path.replace(/\/$/, '')
    p = p.name.concat(path.replace(normPath, '').replace(/\//g, '.'))
    p = p.replace(/\.js$/, '')
  else
    ''
# retrieves the namespaces from file returns a promise
#
# Path -> Promise [Namespace]
mod.nameSpaces = (path) ->
  return mod.readFile(path.concat('/.namespace-map.json')).then((content) ->
    a = JSON.parse(content)
    return _.map(a, (ns) ->
      ns.path = plib.join(path, ns.path)
      return ns
    )
  )

# promise wrapper around normal readdir
#
# String -> Promise [string]
mod.readdir = (path) ->
  new Promise((resolve, reject) ->
    fs.readdir(path, (err, files) ->
      if err then reject(err) else resolve(files)
    )
  )

# Path -> Promise string
mod.readFile = (path) ->
  new Promise((resolve, reject) ->
    fs.readFile(path, 'UTF-8', (err, data) ->
      if err then reject(err) else resolve(data)
    )
  )

module.exports = mod
