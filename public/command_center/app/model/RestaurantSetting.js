/**
 * Restaurant Setting Class
 *
 */

Ext.define('TC.model.RestaurantSetting', {
	extend : 'Ext.data.Model',
	config: {
		fields: [
	    {name: "id", type: "int"},
	    {name: "key", type: "string"},
	    {name: "language", type: "string"}
	  ],
		proxy: {
			type: 'localstorage',
			id  : 'restaurant-setting'
		}
	},
	
	validateKey: function(key,callback){
		var me = this;
		TC.ajaxRequest({
			url: $tc.url('validate_license_key'),
			params: {
        key: key
	    },
	    success: function(response) {
	    	var res = Ext.decode(response.responseText);
	    	me.set('key',key);
	    	me.save();
	    	callback(res.result);
	    },
	    failure: function(response) {
	    	callback(false);
	    }
		});
	}
  
});
