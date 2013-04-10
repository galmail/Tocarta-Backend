/**
 * @class TC.view.settings.WaiterLogin
 * @extends Ext.Panel
 *
 * WaiterLogin Panel
 * @description This panel display the waiter login
 **/

Ext.define('TC.view.settings.WaiterLogin', {
	extend: 'Ext.Panel',
	xtype: 'waiter-login',
	config: {
		cls: 'tcWaiterLogin',
		layout: {
			type: 'vbox',
			align: 'center'
		},
		items: [
			{
				cls: 'tcWaiterCode',
				layout: {
					type: 'hbox',
					align: 'center'
				},
				flex: 1,
				items: [
					{ itemId: 'box1', html: '<input class="box" type="password" value="" disabled="disabled" />' },
					{ itemId: 'box2', html: '<input class="box" type="password" value="" disabled="disabled" />' },
					{ itemId: 'box3', html: '<input class="box" type="password" value="" disabled="disabled" />' },
					{ itemId: 'box4', html: '<input class="box" type="password" value="" disabled="disabled" />' }
				]
			},
			{
				cls: 'tcWaiterPad',
				layout: 'vbox',
				flex: 4,
				defaults: {
					layout: {
						type: 'hbox',
						pack: 'center'
					},
					cls: 'tcWaiterPadLine',
					defaults: {
						xtype: 'button',
						cls: 'tcWaiterPadButton'
					},
				},
				items: [
					{
						items: [
							{ itemId: 'btn1', text: '1' },
							{ itemId: 'btn2', text: '2' },
							{ itemId: 'btn3', text: '3' }
						]
					},
					{
						items: [
							{ itemId: 'btn4', text: '4' },
							{ itemId: 'btn5', text: '5' },
							{ itemId: 'btn6', text: '6' }
						]
					},
					{
						items: [
							{ itemId: 'btn7', text: '7' },
							{ itemId: 'btn8', text: '8' },
							{ itemId: 'btn9', text: '9' }
						]
					}
				]
			}
		]
	}
	
});
