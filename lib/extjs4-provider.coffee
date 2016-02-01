{completions, Context} = require './completions'
fs = require 'fs'

module.exports =
class Extjs4Provider
  selector: '.source.js'

  getSuggestions: ({prefix, editor, bufferPosition, basePath}) ->
    # console.log "got prefix: ", prefix

    try
      nsMap = JSON.parse(fs.readFileSync('.namespace-map.json', 'utf8'))
    catch error
      console.error error
      return []

    if editor && bufferPosition
      prefix = @getPrefix editor, bufferPosition

    console.log 'got prefix', prefix

    context = new Context(nsMap, prefix)

    console.log 'got context', context

    suggestions = completions(context)
    console.log 'got suggestions', suggestions

    return suggestions

  getPrefix: (editor, bufferPosition) ->
    # Whatever your prefix regex might be
    regex = /[\w0-9_.-]+$/

    # Get the text for the line up to the triggered buffer position
    line = editor.getTextInRange([[bufferPosition.row, 0], bufferPosition])

    # Match the regex to the line, and return the match
    line.match(regex)?[0] or ''
