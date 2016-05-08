'use babel';

import AtomColorSchemeSelectorColorsDb from '../lib/atom-color-scheme-selector-colorsDb';

describe('AtomColorSchemeSelectorColorsDb', () => {
  it('should list all color schemes', () => {
    let db = new AtomColorSchemeSelectorColorsDb();
    expect(db.load()).toBe([{"stuff":true}]);
  });
});
