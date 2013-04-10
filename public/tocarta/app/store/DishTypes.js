/**
 * DishTypes Store
 * 
 */
Ext.define('TC.store.DishTypes', {
    extend  : 'Ext.data.Store',
    requires: ['TC.model.Dishtype'],
    config: {
    	model: 'TC.model.Dishtype'
    }
});
