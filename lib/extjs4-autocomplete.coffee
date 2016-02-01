fs = require 'fs'

module.exports =
  provider: null

  activate: ->
    # check for .namespace-map.json
    try
      nsMap = JSON.parse(fs.readFileSync('.namespace-map.json', 'utf8'))
      atom.notifications.addInfo('.namespace-map.json was found!')
    catch error
      atom.notifications.addWarning('.namespace-map.json was not found!', {
        detail: error,
        dismissable: true
      })

  deactivate: ->
    @provider = null

  provide: ->
    unless @provider?
      # console.log "providing extjs4-autocomplete"
      Extjs4Provider = require('./extjs4-provider')

      @provider = new Extjs4Provider()

    return @provider
