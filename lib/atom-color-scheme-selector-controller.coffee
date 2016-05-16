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

  activateThemes: (item, ui) ->
    new Promise (resolve) =>
      # @config.observe runs the callback once, then on subsequent changes.
      atom.themes.config.observe 'core.themes', =>
        atom.themes.deactivateThemes()

        atom.themes.warnForNonExistentThemes()

        atom.themes.refreshLessCache() # Update cache for packages in core.themes config

        promises = []
        if atom.themes.packageManager.resolvePackagePath(item)
          console.log "new theme", item
          promises.push(atom.themes.packageManager.activatePackage(item))
        else
          console.warn("Failed to activate theme '#{themeName}' because it isn't installed.")
        if atom.themes.packageManager.resolvePackagePath(ui)
          console.log "current ui", ui
          promises.push(atom.themes.packageManager.activatePackage(ui))
        else
          console.warn("Failed to activate theme '#{themeName}' because it isn't installed.")

        Promise.all(promises).then =>
          atom.themes.addActiveThemeClasses()
          atom.themes.refreshLessCache() # Update cache again now that @getActiveThemes() is populated
          atom.themes.loadUserStylesheet()
          atom.themes.reloadBaseStylesheets()
          atom.themes.initialLoadComplete = true
          atom.themes.emitter.emit 'did-change-active-themes'
          console.log "made it through the promises"
          resolve()
