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
        url : $tc.nodeserver+"/proxy"
			},
			autoLoad: true
    }
});
