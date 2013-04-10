/**
 * @class TC.view.toolbars.BottomToolbar
 * @extends Ext.Toolbar
 *
 * Bottom Toolbar
 *
 **/

Ext.define('TC.view.toolbars.BottomToolbar', {
	extend : 'Ext.Toolbar',
	xtype : 'bottom-toolbar',
	config : {
		cls: 'tcBottomToolbar',
		// title : 'Mi BottomToolbar',
		items : [
			{
				id: 'tcHelpBtnId',
				xtype: 'button',
				// text: 'Show Help',
				iconMask: true,
    		iconCls: 'info',
    		ui: 'plain'
			},
			// {
				// html: '<iframe src="http://www.facebook.com/plugins/like.php?href=http://tocarta.es" scrolling="no" frameborder="0" style="border:none; width:450px; height:80px"></iframe>'
			// },
			// {
				// id: 'tcLoadAppBtnId',
				// xtype: 'button',
				// ui: 'action',
				// text: 'Load App'
			// },
			// {
				// id: 'tcUpdateAppBtnId',
				// xtype: 'button',
				// ui: 'action',
				// text: 'Update App'
			// },
			// {
				// id: 'tcShowSurveyBtnId',
				// xtype: 'button',
				// text: 'Survey'
			// },
			{ xtype: 'spacer' },
			{
				id: 'tcSwitchTableBtnId',
				xtype: 'button',
				// text: 'Switch Table',
				iconMask: true,
    		icon: 'resources/img/common/logo/minilogo.png',
    		ui: 'plain'
			}
		]
	}
});
