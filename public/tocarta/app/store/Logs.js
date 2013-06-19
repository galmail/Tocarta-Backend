/**
 * Logs Store
 * 
 */
Ext.define('TC.store.Logs', {
    extend  : 'Ext.data.Store',
    requires: ['TC.model.Logger'],
    config: {
    	model   : 'TC.model.Logger',
    	proxy: {
				type: 'localstorage',
				id  : 'logger'
			},
    	localProxy: {
				type: 'localstorage',
				id  : 'logger'
			},
			remoteProxy: {
				type: 'ajax',
        url: $tc.nodeserver+"/proxy",
        writer: {
	    		type: 'json',
	    		root: 'logs'
	    	}
			},
			listeners: {
				beforesync: function(){
					console.log('fires before sync....');
				},
				write: function(self){
					console.log('fires after successful write to proxy....');
					if(self && (self.getProxy().alias[0] == "proxy.ajax")){
						console.log('cleaning up local logs and starting over...');
						self.setProxy(self.getLocalProxy());
						self.load(function(){
							self.removed = self.getData().items;
							self.sync();
						});
						// self.LOCK_SYNC = false;
					}
				},
				load: function(self){
					console.log('fires after load...');
					self.NUM_LOGS = self.getCount();
				}
			}
    },
    
    NUM_LOGS: 0,
    MAX_LOGS: 9999,
		MIN_LOGS_TO_SYNC: 10, 
    LOCK_SYNC: false,
    
    setup: function(){
    	console.log('setup logs');
    	this.load(function(){
    		// clear log store to save memory
    		TC.logs.clearData();
    	});
    },
    
    sumLog: function(){
    	this.NUM_LOGS++;
    }
    
});
