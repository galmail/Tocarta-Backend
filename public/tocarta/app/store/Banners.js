/**
 * Banners Store
 * 
 */
Ext.define('TC.store.Banners', {
    extend  : 'Ext.data.Store',
    requires: ['TC.model.Banner'],
    config: {
    	model: 'TC.model.Banner'
    }
});
