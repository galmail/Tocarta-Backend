/**
 * Menu Class
 *
 */

Ext.define('TC.model.Menu', {
	extend : 'Ext.data.Model',
	config: {
		fields: [
	    {name: "id", type: "int"},
	    {name: "lang", type: "string"},
	    {name: "sections", persist: true},
	    {name: "name", type: "string"},
	    {name: "menu_type", type: "string"},
	    {name: "price", type: "float"},
	    {name: "valid_from_hour", type: "float"},
	    {name: "valid_till_hour", type: "float"},
	    {name: "valid_days", type: "string"}
	  ],
	  associations: [
	  	{type: 'belongsTo', model: 'TC.model.Restaurant', name: 'restaurant'},
	    {type: 'hasMany', model: 'TC.model.Section', name: 'sections'}
	  ]
	}
});
