/**
 * @class TC.view.help.HelpView
 * @extends Ext.Panel
 *
 * HelpView Panel
 * @description This panel display the help view
 **/

Ext.define('TC.view.help.HelpView', {
	extend: 'Ext.Panel',
	xtype: 'help-view',
	
	config: {
		//floating: true,
		modal: true,
		hideOnMaskTap: true,
		centered: true,
		width: 300,
		height: 300,
		//style: 'background-color:yellow',
		styleHtmlContent: true,
		scrollable: 'vertical',
		items: [
			{
				html: '<p>this is the help view panel</p>'
			}
		]
	}
});
