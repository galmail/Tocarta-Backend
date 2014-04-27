/**
 * Image Class
 *
 */

Ext.define('TC.model.Image', {
	extend : 'Ext.data.Model',
	config: {
		fields: [
	    {name: "source", type: "string"},
	    {name: "dest", type: "string"}
	  ]
	},
	
	fetch: function(options){
		var me = this;
		var fileTransfer = new FileTransfer();
		var imgDirectory = $tc.getUri() + me.get('dest');
		console.log("target image to fetch is: " + imgDirectory);
		fileTransfer.download(
		    me.get('source'),
		    imgDirectory,
		    options.success,
		    options.failure
		);
	}
	
});
