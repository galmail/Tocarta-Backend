/**
 * Section Class
 *
 */

Ext.define('TC.model.Section', {
	extend : 'Ext.data.Model',
	requires: ['TC.model.Subsection','TC.model.Dish'],
	config: {
		fields: [
	    {name: "id", type: "int"},
	    {name: "hasBigSubsections", type: "boolean", defaults: false},
	    {name: "dishes_per_page", type: "int"},
	    //{name: "menu_id", type: "int"},
	    {name: "name", type: "string"},
	    {name: "short_title", type: "string"},
	    {name: "position", type: "int"},
	    {name: "mini", type: "string"},
	    {name: "mini_photo_url", type: "string",
	    	convert: function(value, record){
	    		return $tc.getUri() + record.get("mini");
	    	}
	    },
	    {name: "thumbnail", type: "string"},
	    {name: "thumbnail_photo_url", type: "string",
	    	convert: function(value, record){
	    		return $tc.getUri() + record.get("thumbnail");
	    	}
	    }
	  ],
	  associations: [
	  	{type: 'belongsTo', model: 'TC.model.Menu', name: 'menu'},
	  	{type: 'hasMany', model: 'TC.model.Subsection', name: 'subsections'},
	    {type: 'hasMany', model: 'TC.model.Dish', name: 'dishes'}
	  ]
	}
	
});
