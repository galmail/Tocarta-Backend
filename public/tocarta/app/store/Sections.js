/**
 * Sections Store
 * 
 */
Ext.define('TC.store.Sections', {
  extend  : 'Ext.data.Store',
  requires: ['TC.model.Section'],
  config: {
    model   : 'TC.model.Section'
  }
    
});
