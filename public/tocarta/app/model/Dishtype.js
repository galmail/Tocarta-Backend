/**
 * Dishtype Class
 *
 */

Ext.define('TC.model.Dishtype', {
	extend : 'Ext.data.Model',
  config: {
  	fields: [
	    {name: "id", type: "int"},
	    {name: "name", type: "string"},
	    {name: "description", type: "string"},
	    {name: "small_icon", type: "string"},
	    {name: "small_icon_url", type: "string",
	    	convert: function(value, record){
	    		return $tc.getUri() + record.get("small_icon");
	    	}
	    },
	    {name: "big_icon", type: "string"},
	    {name: "big_icon_url", type: "string",
	    	convert: function(value, record){
	    		return $tc.getUri() + record.get("big_icon");
	    	}
	    }
	  ]
  }
});
