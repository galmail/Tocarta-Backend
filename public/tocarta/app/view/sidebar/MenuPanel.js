/**
 * @class TC.view.sidebar.MenuPanel
 * @extends Ext.navigation.View
 *
 * Menu Panel
 *
 **/

Ext.define('TC.view.sidebar.MenuPanel', {
	extend: 'Ext.navigation.View',
	requires: ['TC.view.sidebar.MenuPanelListView'],
	xtype: 'menu-panel',
	config: {
		cls: 'tcMenuPanel',
		useTitleForBackButtonText: false,
		layout: {
			type: 'card',
      animation: null
    },
		navigationBar: {
			cls: 'tcMenuPanelTopBar',
			ui: 'light',
			docked: 'top',
			layout: {
				type: 'hbox',
				pack: 'start',
				align: 'center'
			}
		},
		items: [
			{
				xtype: 'menu-panel-listview'
			}
		]
	}
});
