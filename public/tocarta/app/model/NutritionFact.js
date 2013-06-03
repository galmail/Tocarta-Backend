/**
 * NutritionFact Class
 *
 */

Ext.define('TC.model.NutritionFact', {
	extend : 'Ext.data.Model',
	config: {
		fields: [
	    {name: "id", type: "int"},
	    {name: "dish_id", type: "int"},
	    {name: "description", type: "string"},
	    {name: "carbs", type: "int"},
	    {name: "fats", type: "int"},
	    {name: "proteins", type: "int"},
	    {name: "cholesterol", type: "int"},
	    {name: "calories", type: "int"}
	  ],
	  associations: [
	    {type: 'belongsTo', model: 'TC.model.Dish', name: 'dish'}
	  ]
	}
});
