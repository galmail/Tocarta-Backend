/**
 * Agreement Class
 *
 */

Ext.define('TC.model.Agreement', {
	extend : 'Ext.data.Model',
	config: {
		fields: [
	    {name: "id", type: "int"},
	    {name: "name", type: "string"},
	    {name: "title", type: "string"},
	    {name: "description", type: "string"},
	    {name: "content", type: "string"},
	    {name: "safe_content", type: "string",
	    	convert: function(value, record){
	    		return escape(record.get("content"));
	    	}
	    },
	    {name: "legal_type", type: "string"},
	    {name: "locale", type: "string"}
	  ],
	  associations: [
	  	{type: 'belongsTo', model: 'TC.model.Restaurant', name: 'restaurant'}
	  ]
	}
	
	
	
});
