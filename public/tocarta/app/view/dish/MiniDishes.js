/**
 * @class TC.view.dish.MiniDishes
 * @extends Ext.DataView
 *
 * MiniDishes DataView
 * @description Mini dishes as buttons
 **/

Ext.define('TC.view.dish.MiniDishes', {
	extend: 'Ext.DataView',
	xtype: 'minidishes-view',
	config: {
		cls: 'tcMiniDishesView',
		itemTpl: new Ext.XTemplate(
			'<div id="minidish_{id}" class="minidish">',
      	'<img src="{mini_photo_url}" />',
      	'<div class="minidish_title">{name}</div>',
      	'<div class="minidish_price">€ {price:this.twoDecimals}</div>',
      '</div>',
		{
			twoDecimals: function(price) {
				return $tc.formatNumber(price);
			}
		})
	}
});
