/**
 * @class TC.view.loading.Loader
 * @extends Ext.Panel
 *
 * Loader Panel
 * @description This panel loads the app (configurations, languages, menus, the restaurant info., events and advertisements)
 **/

Ext.define('TC.view.loading.Loader', {
	extend: 'Ext.Panel',
	xtype: 'loader-view',
	config: {
		html: '<h1>'+$T.loading_app+'</h1>'
	}
});
