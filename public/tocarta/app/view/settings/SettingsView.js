/**
 * @class TC.view.settings.SettingsView
 * @extends Ext.Panel
 *
 * SettingsView Panel
 * @description This panel display the settings
 **/

Ext.define('TC.view.settings.SettingsView', {
	requires: ['TC.view.settings.WaiterLogin','TC.view.settings.SwitchTable'],
	extend: 'Ext.Panel',
	xtype: 'settings-view',
	
	config: {
		cls: 'tcSettingsView',
		centered: true,
		modal: true,
		hideOnMaskTap: false,
		items: [
			{
				docked: 'top',
				xtype: 'toolbar',
				title: $TO.settings,
				items: [
					{
						itemId: 'cancelButtonId',
						xtype: 'button',
						text: $TO.cancel
					},
					{ xtype: 'spacer' },
					{
						itemId: 'saveButtonId',
						hidden: true,
						xtype: 'button',
						ui: 'action',
						text: $TO.save
					}
				]
			},
			{
				itemId: 'tcSettingsContainerId',
				cls: 'tcSettingsContainer',
				layout: {
					type: 'card',
					animation: {
						type: 'flip'
					}
				},
				items: [
					{
						itemId: 'tcWaiterLoginId',
						xtype: 'waiter-login'
					},
					{
						itemId: 'tcSwitchTableId',
						xtype: 'switch-table'
					}
				]
			}
		]
	}
	
	
});
