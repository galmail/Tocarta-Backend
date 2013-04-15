/**
 * NutritionFacts Store
 * 
 */
Ext.define('TC.store.NutritionFacts', {
    extend  : 'Ext.data.Store',
    requires: ['TC.model.NutritionFacts'],
    config: {
    	model   : 'TC.model.NutritionFacts'
    }
});
