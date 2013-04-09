/**
 * Restaurant Activity Class
 *
 */

Ext.define('TC.model.Activity', {
	extend : 'Ext.data.Model',
	requires: ['TC.model.Order'],
	config: {
		fields: [
	    {name: "id", type: "int"},
	    {name: "name", type: "string"},
	    {name: "table_number", type: "int"},
	    {name: "date", type: "string"},
	    {name: "ack", type: "string"},
	    {name: "order", persist: true}
	  ],
	  associations: [
	    {type: 'hasOne', model: 'TC.model.Order', name: 'order'}
	  ]
	},
	
	ack: function(callback){
		var me = this;
		TC.ajaxRequest({
  		url: $tc.url('ack_activity'),
  		params: {
  			activity_id: me.getId()
  		},
  		success: function(response){
  			var res = Ext.decode(response.responseText);
  			// if(res.result){
  				// me.set("ack",res.ack);
  			// }
  			callback(res.result,me);
  		},
  		failure: function(){
  			callback(false,me);
  		}
  	});
	}
	
});
