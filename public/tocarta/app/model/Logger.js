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
	
	MAX_LOGS: 100,
	MIN_LOGS_TO_SYNC: 5,
	
	log: function(){
		var _logs = TC.logs.getCount();
		if(_logs>this.MAX_LOGS) return false;
		TC.logs.add(this);
		if(_logs>this.MIN_LOGS_TO_SYNC) this.sync_logs();
	},
	
	
	/**
	 * This function send all logs to the logging/analytics server
	 */
	sync_logs: function(){
		// check if connection is on
		if(!$tc.checkConnection()) return false;
		setTimeout(function(){
			console.log('*** sending logs to server...');
			TC.logs.setProxy(TC.logs.getRemoteProxy());
			TC.logs.sync();
		},500);
	}
	
});
