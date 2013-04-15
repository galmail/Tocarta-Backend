/**
 * DishType Class
 *
 */

Ext.define('TC.model.DishType', {
	extend : 'Ext.data.Model',
  config: {
  	path: '/img/dish_types/',
  	fields: [
	    {name: "id", type: "int"},
	    {name: "name", type: "string"},
	    {name: "icon_file_name", type: "string"},
	    {name: "icon_url", type: "string",
	    	convert: function(value, record) {
	    		return $tc.getUri() + record.getPath() + record.get("icon_file_name");
	    	}
	   	}
	  ]
	  // associations: [
      // {type: 'belongsTo', model: 'TC.model.Dish', name: 'dish'}
    // ]
  }
});
