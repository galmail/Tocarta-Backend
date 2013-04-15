/**
 * OrderItems Store
 * 
 */
Ext.define('TC.store.OrderItems', {
  extend: 'Ext.data.Store',
  requires: ['TC.model.OrderItem'],
  config: {
  	model: 'TC.model.OrderItem'
  }
  
});
