Extjs4Autocomplete = require '../lib/extjs4-autocomplete'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "Extjs4Autocomplete", ->
  [workspaceElement, activationPromise] = []

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    activationPromise = atom.packages.activatePackage('extjs4-autocomplete')

  describe "when the extjs4-autocomplete:toggle event is triggered", ->
    it "hides and shows the modal panel", ->
      # Before the activation event the view is not on the DOM, and no panel
      # has been created
      expect(workspaceElement.querySelector('.extjs4-autocomplete')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.commands.dispatch workspaceElement, 'extjs4-autocomplete:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(workspaceElement.querySelector('.extjs4-autocomplete')).toExist()

        extjs4AutocompleteElement = workspaceElement.querySelector('.extjs4-autocomplete')
        expect(extjs4AutocompleteElement).toExist()

        extjs4AutocompletePanel = atom.workspace.panelForItem(extjs4AutocompleteElement)
        expect(extjs4AutocompletePanel.isVisible()).toBe true
        atom.commands.dispatch workspaceElement, 'extjs4-autocomplete:toggle'
        expect(extjs4AutocompletePanel.isVisible()).toBe false

    it "hides and shows the view", ->
      # This test shows you an integration test testing at the view level.

      # Attaching the workspaceElement to the DOM is required to allow the
      # `toBeVisible()` matchers to work. Anything testing visibility or focus
      # requires that the workspaceElement is on the DOM. Tests that attach the
      # workspaceElement to the DOM are generally slower than those off DOM.
      jasmine.attachToDOM(workspaceElement)

      expect(workspaceElement.querySelector('.extjs4-autocomplete')).not.toExist()

      # This is an activation event, triggering it causes the package to be
      # activated.
      atom.commands.dispatch workspaceElement, 'extjs4-autocomplete:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        # Now we can test for view visibility
        extjs4AutocompleteElement = workspaceElement.querySelector('.extjs4-autocomplete')
        expect(extjs4AutocompleteElement).toBeVisible()
        atom.commands.dispatch workspaceElement, 'extjs4-autocomplete:toggle'
        expect(extjs4AutocompleteElement).not.toBeVisible()
