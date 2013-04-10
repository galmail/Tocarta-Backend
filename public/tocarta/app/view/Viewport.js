Ext.define('TC.view.Viewport', {
	extend : 'Ext.Container',
	requires : [
		'TC.view.toolbars.TopToolbar',
		'TC.view.toolbars.BottomToolbar',
		'TC.view.toolbars.MsgToolbar',
		'TC.view.order.OrderView',
		'TC.view.help.HelpView',
		'TC.view.multilang.PickLanguageView',
		'TC.view.filter.FilterView',
		// 'TC.view.welcome.WelcomeView',
	],
	xtype: 'viewport',
	config : {
		cls: 'tcViewport',
		fullscreen : true,
		layout : 'card',
		cachedViews: [
			// Main Menu
		],
		
		items : [
			{
				cls: 'tcEmptyScreen',
				// xtype : 'welcome-screen',
				// fullscreen: true
			},
			{
				itemId: 'tcTopToolbarId',
				xtype : 'top-toolbar',
				docked : 'top'
			},
			{
				itemId: 'tcMsgToolbarId',
				xtype : 'msg-toolbar',
				docked : 'top'
			},
			{
				itemId: 'tcBottomToolbarId',
				xtype : 'bottom-toolbar',
				docked : 'bottom'
			},
			{
				xtype: 'order-view',
				hidden: true
			},
			{
				xtype: 'help-view',
				hidden: true
			},
			{
				xtype: 'filter-view',
				hidden: true
			}
		]
	}
	
	
});
