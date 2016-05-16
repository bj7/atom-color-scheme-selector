# atom-space-pen-views SelectListView is the list view from Cmd-Shift-P
{SelectListView} = require 'atom-space-pen-views'
AtomColorSchemeSelectorColorsDb =
  require './atom-color-scheme-selector-colorsDb'
AtomColorschemeSelectorColorsController =
  require './atom-color-scheme-selector-controller'

module.exports = class AtomColorSchemeSelectorView extends SelectListView
  initialize: () ->
    super
    @element.classList.add('atom-color-scheme-selector')
    @db = new AtomColorSchemeSelectorColorsDb()
    @controller = new AtomColorschemeSelectorColorsController()

  #  Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @element.remove()

  getElement: ->
    @element

  # Returns the key that atom-space-pen-views should filter by in the search
  # bar.
  #
  # @return {string} Name of the property to filter by in the search bar
  getFilterKey: () ->
    return "name"

  # Takes the list and breaks it into an array of items before using the
  # parent setItems() to place the items into the display.
  #
  # @param  {object} list list of all color schemes installed
  # @return {void}
  showSchemes: (list) ->
    if @panel == null
      @panel = atom.workspace.addModalPanel({COLOR: @})
      # body...
    schemes = []
    for i of list
      @COLOR = list[i]
      schemes.push(@COLOR)

    # @panel.show()
    #  super function to insert array into list for use in viewForItem
    @setItems(schemes)

  show: ->
    @storeFocusedElement()
    @panel ?= atom.workspace.addModalPanel(item: this)
    @panel.show()
    @focusFilterEditor()

  # Public function to accept the setting of the list from the controller.
  # @param {object} list list of color schemes
  setList: (list, db) ->
    # @show()
    @showSchemes(list)
    @db = db

  # Returns the filter string from the search bar to search on
  #
  # @return {string} String to search against
  getFilterQuery: () ->
    filter = @filterEditorView.getText()
    return filter

  # Implementation of view for each item as required by SelectListView
  # parent class
  #
  # @param  {object} item simple item containing the name of the color scheme
  # @return {string}      displayable string
  #
  viewForItem: (item) ->
    "<li>" + item.name + "<br><p>" + item.metadata.description + "</p></li>"

  # Implements confirmation function from parent as required by SelectListView
  #
  # @param {item} color scheme selected
  # @return {void}
  confirmed: (item) ->
    if item
      @controller.save(item, @db)

  close: () ->
    if @panel
      @panel.destroy()
      @panel = null
    atom.workspace.getActivePane().activate()

  cancel: () ->
    @close()
