/**
 * Tables Store
 * 
 */
Ext.define('TC.store.Tables', {
    extend  : 'Ext.data.Store',
    requires: ['TC.model.Table'],
    config: {
    	model   : 'TC.model.Table'
    }
});
