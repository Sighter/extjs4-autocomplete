module.exports =
  provider: null

  activate: ->
    console.log "activating extjs4-autocomplete"

  deactivate: ->
    @provider = null

  provide: ->
    unless @provider?
      console.log "providing extjs4-autocomplete"
      Extjs4Provider = require('./extjs4-provider.coffee')
      @provider = new Extjs4Provider()

    return @provider
