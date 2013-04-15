/**
 * @class TC.view.dish.DishPhotoFullSize
 * @extends Ext.Panel
 *
 * DishPhotoFullSize Panel
 * @description This panel display the dish photo tab
 **/

Ext.define('TC.view.dish.DishPhotoFullSize', {
	extend: 'Ext.Panel',
	xtype: 'dish-photo-fullsize',
	config: {
		cls : 'tcDishPhotoFullSize',
		fullscreen: true,
		// modal: true,
		// hideOnMaskTap: true,
		// centered: true,
		html: 'here goes the photo'
	}
});