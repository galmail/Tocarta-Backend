/**
 * Dish Class
 *
 */

Ext.define('TC.model.Dish', {
	extend : 'Ext.data.Model',
	requires: ['TC.model.Dishtype','TC.model.Comment'],
	config: {
		fields: [
	    {name: "id", type: "int"},
	    {name: "badge_name", type: "string"},
	    //{name: "section_id", type: "int"},
	    //{name: "subsection_id", type: "int"},
	    {name: "name", type: "string"},
	    {name: "short_title", type: "string"},
	    {name: "price", type: "float"},
	    //{name: "dish_types", persist:true},
	    {name: "description", type: "string"},
	    {name: "rating", type: "int"},
	    {name: "story", type: "string"},
	    {name: "video", type: "string"},
	    {name: "nutrition_facts", type: "string"},
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
	    {type: 'hasMany', model: 'TC.model.Dishtype', name: 'dishtypes'},
	    {type: 'hasMany', model: 'TC.model.Comment', name: 'comments'}
	  ]
	}
  
});
