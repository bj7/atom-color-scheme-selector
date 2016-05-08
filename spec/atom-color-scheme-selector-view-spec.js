'use babel';

import AtomColorSchemeSelectorView from '../lib/atom-color-scheme-selector-view';

describe('AtomColorSchemeSelectorView', () => {
  it('should list all packages', () => {
    let view = new AtomColorSchemeSelectorView();
    expect(view.setList(["this","that","the other"])).toBe(typeof(Object()));
  });
});
