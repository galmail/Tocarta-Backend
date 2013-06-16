/**
 * Subsection Class
 *
 */

Ext.define('TC.model.Subsection', {
	extend : 'Ext.data.Model',
	requires: ['TC.model.Dish'],
	config: {
		fields: [
	    {name: "id", type: "int"},
	    //{name: "menu_id", type: "int"},
	    {name: "name", type: "string"},
	    {name: "short_title", type: "string"},
	    {name: "position", type: "int"},
	    {name: "mini", type: "string"},
	    {name: "mini_photo_url", type: "string",
	    	convert: function(value, record){
	    		return $tc.checkImgUrl(record.get("mini"));
	    	}
	    },
	    {name: "thumbnail", type: "string"},
	    {name: "thumbnail_photo_url", type: "string",
	    	convert: function(value, record){
	    		return $tc.checkImgUrl(record.get("thumbnail"));
	    	}
	    }
	  ],
	  associations: [
	  	{type: 'belongsTo', model: 'TC.model.Section', name: 'section'},
	    {type: 'hasMany', model: 'TC.model.Dish', name: 'dishes'}
	  ]
	}
});
