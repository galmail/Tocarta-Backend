/**
 * @class TC.view.loading.Updater
 * @extends Ext.Panel
 *
 * Updater View
 * @description This panel updates the app (configurations, languages, menus, the restaurant info., events and advertisements)
 * It also check when is the next time to update
 **/

Ext.define('TC.view.loading.Updater', {
	extend: 'Ext.Panel',
	xtype: 'updater-view',
	config: {
		cls: 'tcUpdaterView',
		html: '<h1>'+$TO.updating_app+'</h1>'
	}
});
