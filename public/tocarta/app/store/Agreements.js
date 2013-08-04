/**
 * Agreements Store
 * 
 */
Ext.define('TC.store.Agreements', {
    extend  : 'Ext.data.Store',
    requires: ['TC.model.Agreement'],
    config: {
    	model: 'TC.model.Agreement'
    }
});
