module.exports =
  provider: null

  activate: ->
    # console.log "activating extjs4-autocomplete"
    # console.log 'got path', atom.project.getDirectories()

  deactivate: ->
    @provider = null

  provide: ->
    unless @provider?
      # console.log "providing extjs4-autocomplete"
      Extjs4Provider = require('./classpath-provider')

      mapping = [
        name: 'Utils'
        folder: 'utils'
      ,
        name: 'Lier'
        folder: 'app'
      ]

      @provider = new Extjs4Provider(mapping)

    return @provider
