/**
 * NutritionFacts Store
 * 
 */
Ext.define('TC.store.NutritionFacts', {
    extend  : 'Ext.data.Store',
    requires: ['TC.model.NutritionFact'],
    config: {
    	model   : 'TC.model.NutritionFact'
    }
});
