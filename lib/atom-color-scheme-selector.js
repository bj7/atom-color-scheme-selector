'use babel';

import AtomColorSchemeSelectorView from './atom-color-scheme-selector-view';
import { CompositeDisposable } from 'atom';
import AtomColorSchemeSelectorColorsDb from './atom-color-scheme-selector-colorsDb';

export default {

  atomColorSchemeSelectorView: null,
  modalPanel: null,
  subscriptions: null,

  activate(state) {
    this.atomColorSchemeSelectorView = new AtomColorSchemeSelectorView(state.atomColorSchemeSelectorViewState);
    this.modalPanel = atom.workspace.addModalPanel({
      item: this.atomColorSchemeSelectorView.getElement(),
      visible: false
    });
    this.db = new AtomColorSchemeSelectorColorsDb();
    // Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    this.subscriptions = new CompositeDisposable();

    // Register command that toggles this view
    this.subscriptions.add(atom.commands.add('atom-workspace', {
      'atom-color-scheme-selector:toggle': () => this.toggle()
    }));
  },

  deactivate() {
    this.modalPanel.destroy();
    this.subscriptions.dispose();
    this.atomColorSchemeSelectorView.destroy();
  },

  serialize() {
    return {
      atomColorSchemeSelectorViewState: this.atomColorSchemeSelectorView.serialize()
    };
  },

  toggle() {
    let listOfPackages = [];
    let rawDb = this.db.load();
    // for (let i in rawDb) {
    //   if (rawDb.hasOwnProperty(i)) {
    //     listOfPackages[i] = new Colors(rawDb[i].name, rawDb[i].set);
    //   }
    // }
    listOfPackages = rawDb;
    this.atomColorSchemeSelectorView.setList(listOfPackages, this.db);
    return (
      this.modalPanel.isVisible() ?
      this.modalPanel.hide() :
      this.modalPanel.show()
    );
  }

};
