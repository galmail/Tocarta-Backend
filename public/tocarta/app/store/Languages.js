/**
 * Languages Store
 * 
 */
Ext.define('TC.store.Languages', {
    extend  : 'Ext.data.Store',
    requires: ['TC.model.Language'],
    config: {
    	model: 'TC.model.Language'
    }
});
