/**
 * @class TC.view.dish.DishVideo
 * @extends Ext.Panel
 *
 * DishVideo Panel
 * @description This panel display the dish video tab
 **/

Ext.define('TC.view.dish.DishVideo', {
	extend: 'Ext.Panel',
	requires: ['Ext.Video'],
	xtype: 'dish-video-tab',
	config: {
		cls : 'tcDishVideo',
		items: [{
			xtype: 'video',
			loop: false
		}]
		// loop: false
		// defaults: {
			// width: 679,
			// height: 456
		// }
	}
});