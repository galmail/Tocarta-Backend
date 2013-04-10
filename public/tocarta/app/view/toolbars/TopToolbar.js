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
		title : '',
		items: [
			{
				itemId: 'tcHomeBtnId',
				cls: 'tcBigBtn',
				xtype: 'button',
				iconMask: true,
    		iconCls: 'home'
			},
			{
				itemId: 'tcSwitchMenuBtnId',
				xtype: 'button',
				// text: 'menu',
				iconMask: true,
    		iconCls: 'tabbed_book',
    		hidden: true
			},
			{
				itemId: 'tcSwitchLanguageBtnId',
				xtype: 'button',
				// text: 'Switch Language',
				iconMask: true,
    		iconCls: 'flag'
			},
			{
				itemId: 'tcFilterBtnId',
				xtype: 'button',
				// text: 'Filter Dishes',
				iconMask: true,
    		iconCls: 'filters',
    		hidden: true
			},
			{ xtype: 'spacer' },
			{
				itemId: 'tcGamesBtnId',
				xtype: 'button',
				// text: 'Games',
				iconMask: true,
    		iconCls: 'games',
    		hidden: true
			},
			{
				itemId: 'tcCallWaiterBtnId',
				xtype: 'button',
				// text: 'Call Waiter'
				iconMask: true,
    		iconCls: 'waiter'
			},
			{
				itemId: 'tcRequestBillBtnId',
				xtype: 'button',
				// text: 'Request Bill',
				iconMask: true,
    		iconCls: 'bill'
			},
			{
				id: 'tcShowOrderBtnId',
				xtype: 'button',
				// text: 'Show Order',
				iconMask: true,
    		iconCls: 'order'
			}
		]
	}
});
