/**
 * Logger Class
 *
 */

Ext.define('TC.model.Logger', {
	extend : 'Ext.data.Model',
	config: {
		fields: [
	    {name: "id", type: "int"},
	    {name: "timestamp", type: "int"},
	    {name: "device_id", type: "string"},
	    {name: "action", type: "string"},
	    {name: "data", type: "object"}
	  ],
	  proxy: {
			type: 'localstorage',
			id  : 'logger'
		}
	},
	
	log: function(){
		var _logs = TC.logs.NUM_LOGS;
		if(_logs>TC.logs.MAX_LOGS || TC.logs.LOCK_SYNC) return false;
		console.log("saving log");
		this.save(); TC.logs.sumLog(); _logs++;
		if(_logs>=TC.logs.MIN_LOGS_TO_SYNC && _logs%TC.logs.MIN_LOGS_TO_SYNC==0) this.sync_logs();
	},
	
	/**
	 * This function send all logs to the logging/analytics server
	 */
	sync_logs: function(){
		console.log("syncing logs now!!!!!!!");
		// check if connection is on
		if(!$tc.checkConnection()) return false;
		// starting to sync
		TC.logs.LOCK_SYNC = true;
		// setTimeout(function(){
			console.log('*** preparing to send logs to server...');
			// TC.logs.removeAll(true);
			TC.logs.setProxy(TC.logs.getLocalProxy());
			TC.logs.load(function(records, operation, success) {
				// set all records to dirty
    		Ext.Array.each(records,function(log){ log.setDirty(true); });
    		// send records to server
				console.log('*** sending '+records.length+' logs to server...');
				TC.logs.setProxy(TC.logs.getRemoteProxy());
				TC.logs.sync();
				// TC.logs.removeAll(true);
			});
		// },100);
	}
	
});
