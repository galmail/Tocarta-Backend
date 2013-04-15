/**
 * Combo Class
 * 
 */

Ext.define('TC.model.Combo', {
	extend : 'Ext.data.Model',
	config: {
		fields : [
			{ name : "id", type : "int"},
			{ name : "name", type : "string"},
			{ name : "description", type : "string"},
			{ name : "price", type : "float"}
		],
		associations: [
	  	{type: 'belongsTo', model: 'TC.model.ComboType', name: 'combotype'},
	    {type: 'hasMany', model: 'TC.model.Dish', name: 'dishes'}
	  ]
	}
});
