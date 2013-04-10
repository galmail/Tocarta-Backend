/**
 * Orders Store
 * 
 */
Ext.define('TC.store.Orders', {
  extend: 'Ext.data.Store',
  requires: ['TC.model.Order'],
  config: {
  	model: 'TC.model.Order'
  }
});
