/**
 * ComboTypes Store
 * 
 */
Ext.define('TC.store.ComboTypes', {
    extend  : 'Ext.data.Store',
    requires: ['TC.model.ComboType'],
    config: {
    	model: 'TC.model.ComboType'
    }
});
