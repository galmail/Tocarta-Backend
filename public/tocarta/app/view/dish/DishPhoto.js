/**
 * @class TC.view.dish.DishPhoto
 * @extends Ext.Panel
 *
 * DishPhoto Panel
 * @description This panel display the dish photo tab
 **/

Ext.define('TC.view.dish.DishPhoto', {
	extend: 'Ext.Panel',
	xtype: 'dish-photo-tab',
	config: {
		cls : 'tcDishPhoto',
		items: [
			{
				itemId: 'tcDishBigBadgeId',
				cls: 'tcBigBadge',
				tpl: new Ext.XTemplate('<tpl if="badge_name"><div class="dish-big-badge">{badge_name}</div></tpl>')
			},
			{
				itemId: 'tcAddDishButtonId',
				cls: 'tcAddButton',
				xtype: 'button',
				text: $T.add
			}
		],
    tpl: new Ext.XTemplate(
    	'<div class="dish-photo-container">',
	    	'<img id="tcDishImgId" class="dish-image" src="{large_photo_url}"/>',
	    	'<div class="dish-info">',
	    		'<div class="dish-description">{description}</div>',
	    		'<div class="dish-price">',
	    			'<span class="euro">€</span>',
	    			'<span class="price">{price:this.twoDecimals}</span>',
	    		'</div>',
    		'</div>',
  		'</div>',
    {
			twoDecimals: function(price) {
				return $tc.formatNumber(price);
			}
		})
	}
});