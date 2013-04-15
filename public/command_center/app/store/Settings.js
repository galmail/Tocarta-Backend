/**
 * Settings Store
 * 
 */
Ext.define('TC.store.Settings', {
    extend  : 'Ext.data.Store',
    requires: ['TC.model.Setting'],
    config: {
    	model: 'TC.model.Setting',
    }
});
