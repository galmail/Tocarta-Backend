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
		items : [
			{
				id: 'tcHelpBtnId',
				xtype: 'button',
				// text: 'Show Help',
				iconMask: true,
    		iconCls: 'info',
    		ui: 'plain'
			},
			{
				id: 'tcChangeLangBtnId',
				xtype: 'button',
				text: $T.change_lang
			},
			{
				id: 'tcFilterDishesBtnId',
				xtype: 'button',
				text: $T.filter_dishes
			},
			{
				id: 'tcShowSurveyBtnId',
				xtype: 'button',
				text: $T.fill_survey
			},
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
