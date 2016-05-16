AtomColorSchemeSelectorColorsDb = require './atom-color-scheme-selector-colorsDb'
AtomColorSchemeSelector = require './atom-color-scheme-selector'

module.exports = class AtomColorSchemeSelectorController
  constructor: () ->
    @db = new AtomColorSchemeSelectorColorsDb()
    @activeUiTheme = null
    @activeSyntaxTheme = null

  save: (item, db) ->
    # get current active theme and ui
    active = atom.themes.getActiveThemeNames()
    theme = active[0]
    ui = active[1]
    console.log item
    @updateThemeConfig(item.name, ui)
    # @activateThemes(item, ui)
    # save configs
    # db.save(item)

  # Update the config with the selected themes
  updateThemeConfig: (activeSyntaxTheme, activeUiTheme) ->
    themes = []
    themes.push(activeUiTheme) if activeUiTheme
    themes.push(activeSyntaxTheme) if activeSyntaxTheme
    console.log themes
    atom.config.set("core.themes", themes) if themes.length > 0
