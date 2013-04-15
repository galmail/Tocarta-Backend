/**
 * @class TC.view.maincontrol.MainContainer
 * @extends Ext.Panel
 *
 * MainContainer Panel
 * @description This panel contains the main view
 **/

Ext.define('TC.view.maincontrol.MainContainer', {
	requires: ['TC.view.maincontrol.TablesView','TC.view.maincontrol.ActivitiesView'],
	extend: 'Ext.Panel',
	xtype: 'main-container',
	config: {
		cls : 'tcMainContainer',
		layout: 'card',
		items: [
			// {
				// docked: 'left',
				// xtype: 'tables-view',
				// width: 200
			// },
			{
				xtype: 'activities-view'
			}
		]
	}
});


