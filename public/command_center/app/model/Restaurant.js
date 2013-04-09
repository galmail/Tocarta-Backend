/**
 * Restaurant Class
 *
 */

Ext.define('TC.model.Restaurant', {
	extend : 'Ext.data.Model',
	requires: ['TC.model.Activity'],
	config: {
		fields: [
	    {name: "id", type: "int"},
	    {name: "name", type: "string"},
	    {name: "logo", type: "string"},
	    {name: "num_tables", type: "string"},
	    {name: "activities", persist: true}
	  ],
	  associations: [
	    {type: 'hasMany', model: 'TC.model.Activity', name: 'activities'}
	  ]
	}
	
});
