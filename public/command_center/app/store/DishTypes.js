/**
 * DishTypes Store
 * 
 */
Ext.define('TC.store.DishTypes', {
    extend  : 'Ext.data.Store',
    requires: ['TC.model.DishType'],
    config: {
    	model: 'TC.model.DishType'
    }
});
