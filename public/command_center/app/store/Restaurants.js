/**
 * Restaurants Store
 * 
 */
Ext.define('TC.store.Restaurants', {
    extend  : 'Ext.data.Store',
    requires: ['TC.model.Restaurant'],
    config: {
    	model   : 'TC.model.Restaurant',
    	proxy: {
				type: 'localstorage',
				id  : 'restaurant'
			}
    }
});
