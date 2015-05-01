module.exports =
class Extjs4Provider
  selector: '.source.js'

  getSuggestions: ({editor, bufferPosition, scopeDescriptor, prefix}) ->
    console.log "got prefix: ", prefix

    suggestion =
      text: 'Hello world'
      type: 'function'

    return [suggestion]
