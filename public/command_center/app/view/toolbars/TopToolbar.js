/**
 * @class TC.view.toolbars.TopToolbar
 * @extends Ext.Toolbar
 *
 * Top Toolbar
 *
 **/

Ext.define('TC.view.toolbars.TopToolbar', {
	extend : 'Ext.Toolbar',
	xtype : 'top-toolbar',
	config : {
		cls: 'tcTopToolbar',
		// title : 'Centro de Mando',
		items: [
			// {
				// id: 'tcHomeBtnId',
				// xtype: 'button',
				// text: 'Home'
			// },
			// { xtype: 'spacer' },
			// {
				// id: 'tcSettingsBtnId',
				// xtype: 'button',
				// text: 'Settings'
			// }
		]
	}
});
