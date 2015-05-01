{filter} = require 'fuzzaldrin'

module.exports =
class RootNamespaceProvider
  mapping: []
  candidates: []

  constructor: (mapping) ->
    @mapping = mapping
    @mapping.push({name: 'Ext', folder: null})

    @candidates = ({text: m.name} for m in mapping)

  getSuggestions: (prefix) ->

    console.log "Filtering: ", @candidates

    res = filter(@candidates, prefix, key: 'text')
