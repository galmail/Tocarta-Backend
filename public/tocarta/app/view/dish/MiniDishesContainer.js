/**
 * @class TC.view.dish.MiniDishesContainer
 * @extends Ext.Panel
 *
 * MiniDishes Container
 * @description This panel display the mini dishes
 **/

Ext.define('TC.view.dish.MiniDishesContainer', {
	requires: ['TC.view.dish.DishTitle','TC.view.dish.MiniDishes'],
	extend: 'Ext.Panel',
	xtype: 'minidishes-container',
	config: {
		cls: 'tcMiniDishesContainer',
		layout: 'vbox',
		items: [
			{
				docked: 'top',
				xtype: 'dish-title-toolbar',
			},
			{
				flex: 1,
				xtype: 'minidishes-view'
			}
		]
	}
});
