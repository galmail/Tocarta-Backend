/**
 * Dishes Store
 * 
 */
Ext.define('TC.store.Dishes', {
    extend  : 'Ext.data.Store',
    requires: ['TC.model.Dish'],
    config: {
    	model   : 'TC.model.Dish'
    }
});
