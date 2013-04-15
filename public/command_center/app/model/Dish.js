/**
 * Dish Class
 *
 */

Ext.define('TC.model.Dish', {
	extend : 'Ext.data.Model',
	config: {
		fields: [
	    {name: "id", type: "int"},
	    {name: "badge_name", type: "string"},
	    //{name: "section_id", type: "int"},
	    //{name: "subsection_id", type: "int"},
	    {name: "name", type: "string"},
	    {name: "price", type: "float"},
	    //{name: "dish_types", persist:true},
	    {name: "description", type: "string"},
	    {name: "rating", type: "int"},
	    {name: "story", type: "string"},
	    {name: "video", type: "string"},
	    {name: "nutrition_facts", type: "string"},
	    {name: "position", type: "int"},
	    {name: "thumbnail", type: "string"},
	    {name: "thumbnail_photo_url", type: "string",
	    	convert: function(value, record){
	    		return $tc.getUri() + record.get("thumbnail");
	    	}
	    },
	    {name: "large", type: "string"},
	    {name: "large_photo_url", type: "string",
	    	convert: function(value, record){
	    		return $tc.getUri() + record.get("large");
	    	}
	    }
	  ],
	  associations: [
	  	{type: 'belongsTo', model: 'TC.model.Section', name: 'section'},
	  	{type: 'belongsTo', model: 'TC.model.Subsection', name: 'subsection'},
	    {type: 'hasMany', model: 'TC.model.DishType', name: 'dish_types'},
	    {type: 'hasMany', model: 'TC.model.Comment', name: 'comments'}
	  ]
	}
  
});
