Ext.define('TC.view.Viewport', {
	extend : 'Ext.Container',
	requires : ['TC.view.toolbars.TopToolbar', 'TC.view.toolbars.BottomToolbar','TC.view.toolbars.MsgToolbar'],
	xtype: 'viewport',
	config : {
		fullscreen : true,
		cls: 'tcViewport',
		layout : 'card',
		cachedViews: [
			// Main Menu
		],
		items : [
			{
				html: 'this is the viewport'
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
			}
		]
	}
	
	
});
