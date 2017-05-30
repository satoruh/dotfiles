const {classes: Cc, interfaces: Ci, utils: Cu} = Components;
let {Preferences} = Cu.import('resource://gre/modules/Preferences.jsm', {});

// firefox preferences
const FIREFOX_PREFS = {
  'browser.tabs.closeWindowWithLastTab': false,
  'browser.tabs.animate': false,
  'browser.tabs.remote.force-enable': true,
};


function addKeyBindings(name, key) {
  vimfx.set(name, vimfx.getDefault(name) + ' ' + key);
};

// key bindings
addKeyBindings('mode.normal.tab_select_next', '<c-n>');
addKeyBindings('mode.normal.tab_select_previous', '<c-p>');


// set firefox preferences
Preferences.set(FIREFOX_PREFS);
