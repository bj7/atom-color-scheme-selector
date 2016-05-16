# atom-color-scheme-selector
An attempt at recreating the command palette style color scheme switcher found in Sublime Text
=======
# atom-color-scheme-selector package

This is my attempt to recreate the command palette color-switching package found in Sublime. It is not ready for mainstream use. <s>It uses private functions found in Atom.core (not a good implementation) because I have not found any APIs for updating the color schemes</s>. It uses the atom.config.set method to handle setting the theme. The theme description is also listed.

The themes listed have not been filtered fully. There are UI themes mixed with the list of syntax themes. I need to remove them, as trying to switch a UI theme will cause tested behavior and most likely break the package. I plan to eventually update the package to allow for UI theme change as well.

![Alt text](https://github.com/bj7/atom-color-scheme-selector/blob/master/Screen%20Shot%202016-05-16%20at%206.40.22%20PM.png)
