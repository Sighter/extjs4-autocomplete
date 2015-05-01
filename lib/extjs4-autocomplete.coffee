Extjs4AutocompleteView = require './extjs4-autocomplete-view'
{CompositeDisposable} = require 'atom'

module.exports = Extjs4Autocomplete =
  extjs4AutocompleteView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @extjs4AutocompleteView = new Extjs4AutocompleteView(state.extjs4AutocompleteViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @extjs4AutocompleteView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'extjs4-autocomplete:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @extjs4AutocompleteView.destroy()

  serialize: ->
    extjs4AutocompleteViewState: @extjs4AutocompleteView.serialize()

  toggle: ->
    console.log 'Extjs4Autocomplete was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
