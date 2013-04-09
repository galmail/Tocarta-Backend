/**
 * Setting Class
 *
 */

Ext.define('TC.model.Setting', {
	extend : 'Ext.data.Model',
	config: {
		fields: [
	    {name: "id", type: "int"},
	    {name: "key", type: "string"},
	    {name: "table", type: "int"},
	    {name: "new_table", type: "boolean", defaultValue: false},
	    {name: "num_dinners", type: "int", defaultValue: 2},
	    {name: "language", type: "string"},
	    {name: "last_update", type: "string"}
	  ],
		proxy: {
			type: 'localstorage',
			id  : 'setting'
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
