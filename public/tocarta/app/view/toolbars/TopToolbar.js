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
	requires: ['Ext.SegmentedButton'],
	config : {
		cls: 'tcTopToolbar',
		title : '',
		items: [
			{
				itemId: 'tcLogoImgId',
				xtype: 'panel',
				html: ''
			},
			{
				itemId: 'tcHomeBtnId',
				hidden: true,
				cls: 'tcBigBtn',
				xtype: 'button',
				iconMask: true,
    		iconCls: 'home'
			},
			{
				itemId: 'tcSwitchMenuBtnId',
				hidden: true,
				xtype: 'button',
				// text: 'menu',
				iconMask: true,
    		iconCls: 'tabbed_book'
			},
			{
				itemId: 'tcSwitchLanguageBtnId',
				hidden: true,
				xtype: 'button',
				// text: 'Switch Language',
				iconMask: true,
    		iconCls: 'flag'
			},
			{
				itemId: 'tcFilterBtnId',
				hidden: true,
				xtype: 'button',
				// text: 'Filter Dishes',
				iconMask: true,
    		iconCls: 'filters'
			},
			{ xtype: 'spacer' },
			{
				itemId: 'tcGamesBtnId',
				hidden: true,
				xtype: 'button',
				// text: 'Games',
				iconMask: true,
    		iconCls: 'games'
			},
			{
				itemId: 'tcCallWaiterBtnId',
				hidden: true,
				xtype: 'button',
				// text: 'Call Waiter'
				iconMask: true,
    		iconCls: 'waiter'
			},
			{
				itemId: 'tcRequestBillBtnId',
				hidden: true,
				xtype: 'button',
				// text: 'Request Bill',
				iconMask: true,
    		iconCls: 'bill'
			},
			{
				id: 'tcShowOrderBtnId',
				hidden: true,
				xtype: 'button',
				// text: 'Show Order',
				iconMask: true,
    		iconCls: 'order'
			},
			{
				xtype: 'segmentedbutton',
				itemId: 'tcAllMenuButtonsId',
				allowDepress: false,
				items: []
			}
		]
	}
});
