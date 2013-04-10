/**
 * Comments Store
 * 
 */
Ext.define('TC.store.Comments', {
    extend  : 'Ext.data.Store',
    requires: ['TC.model.Comment'],
    config: {
    	model: 'TC.model.Comment'
    }
});
