/**
 * @class TC.view.mainmenu.MainMenu
 * @extends Ext.Panel
 *
 * Main Menu Panel
 *
 **/

Ext.define('TC.view.mainmenu.MainMenu', {
	extend : 'Ext.Panel',
	requires : ['TC.view.sidebar.MenuPanel','TC.view.restaurantinfo.RestaurantCarousel','TC.view.dish.DishContainer','TC.view.dish.MiniDishesContainer'],
	xtype: 'main-menu',
	config: {
		layout: 'card',
		cls: 'tcMainMenu',
		items: [
			{
				xtype: 'panel',
				cls: 'tcLeftSidebar',
				width: window.innerWidth/3.2,
				docked: 'left',
				layout: {
					type: 'vbox'
				},
				items: [
					{
						xtype: 'menu-panel',
						flex: 1
					},
					{
						cls: 'tcSidebarBottomToolbar',
						xtype: 'toolbar',
						docked: 'bottom'
					}
				]
			},
			{
				itemId: 'restaurantCarouselId',
				xtype: 'restaurant-carousel'
			},
			{
				itemId: 'dishContainerId',
				xtype: 'dish-container'
			},
			{
				itemId: 'minidishesContainerId',
				xtype: 'minidishes-container'
			}
		]
	}
});
