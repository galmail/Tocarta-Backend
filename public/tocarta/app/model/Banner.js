/**
 * Banner Class
 *
 */

Ext.define('TC.model.Banner', {
	extend : 'Ext.data.Model',
	config: {
		fields: [
	    {name: "id", type: "int"},
	    {name: "name", type: "string"},
	    {name: "large", type: "string"},
	    {name: "large_photo_url", type: "string",
	    	convert: function(value, record){
	    		return $tc.getUri() + record.get("large");
	    	}
	    }
	  ],
	  associations: [
	  	{type: 'belongsTo', model: 'TC.model.Restaurant', name: 'restaurant'}
	  ]
	}
});
