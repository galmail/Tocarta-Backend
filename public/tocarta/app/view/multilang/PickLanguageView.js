/**
 * @class TC.view.multilang.PickLanguageView
 * @extends Ext.Panel
 *
 * Pick a Language Panel
 * @description This panel show several languages of the menu
 **/

Ext.define('TC.view.multilang.PickLanguageView', {
	extend: 'Ext.Panel',
	xtype: 'multilang-view',
	config: {
		cls: 'tcMultiLangPanel',
		layout: {
			type: 'hbox',
			pack: 'center'
		}
	}
});
