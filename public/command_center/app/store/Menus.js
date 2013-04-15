/**
 * Menus Store
 * 
 */
Ext.define('TC.store.Menus', {
  extend  : 'Ext.data.Store',
  requires: ['TC.model.Menu'],
  config: {
  	model   : 'TC.model.Menu'
  }
});
