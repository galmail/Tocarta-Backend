/**
 * Restaurant Activities Store
 * 
 */
Ext.define('TC.store.Activities', {
    extend  : 'Ext.data.Store',
    requires: ['TC.model.Activity'],
    config: {
    	model   : 'TC.model.Activity'
    }
});
