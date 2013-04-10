/**
 * @class TC.view.restaurantinfo.RestaurantCarousel
 * @extends Ext.Panel
 *
 * Restaurant Carousel
 * Displays advertisements, events and restaurant info.
 *
 **/

Ext.define('TC.view.restaurantinfo.RestaurantCarousel', {
	extend : 'Ext.Panel',
	requires: ['Ext.carousel.Carousel'],
	xtype: 'restaurant-carousel',
	config: {
		cls: 'tcRestaurantCarousel',
		layout: 'vbox',
		items: [
			{
				docked: 'top',
				xtype: 'toolbar'
			},
			{
				flex: 1,
				itemId: 'tcRestCarouselId',
				xtype: 'carousel'
			},
			{
				cls: 'tcRestaurantCarouselBottomToolbar',
				xtype: 'toolbar',
				docked: 'bottom'
			}
		]
	}
});
