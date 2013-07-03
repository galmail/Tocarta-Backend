/**
 * Translations Store
 * 
 */
Ext.define('TC.store.Translations', {
    extend  : 'Ext.data.Store',
    requires: ['TC.model.Translation'],
    config: {
    	model: 'TC.model.Translation'
    }
});
