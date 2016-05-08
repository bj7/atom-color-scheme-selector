module.exports = class AtomColorSchemeSelectorColorsDb
  constructor: () ->
    @curList = [{}]

  load: () ->
    # expand filter of Array to filter out any theme with a `-ui` in it
    # since that is a UI theme and not a syntax theme
    Array::filter = (func) -> x for x in this when func(x)
    @curList = atom.themes.getLoadedThemeNames()
    @curList = @curList.filter (x) -> !/-ui/.test(x)
    # console.log @curList
    return @curList

  save: (item) ->
    console.log item, @curList
    for i in [0..@curList.length - 1]
      if item == @curList[i].name
        @curList[i].set = true
      else
        @curList[i].set = false
    console.log @curList
