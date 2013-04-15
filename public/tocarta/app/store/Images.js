/**
 * Images Store
 * 
 */
Ext.define('TC.store.Images', {
  extend  : 'Ext.data.Store',
  requires: ['TC.model.Image'],
  config: {
  	model : 'TC.model.Image'
  }
});
