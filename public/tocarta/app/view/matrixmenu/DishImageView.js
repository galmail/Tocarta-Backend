/**
 * @class TC.view.matrixmenu.DishImageView
 * @extends Ext.Container
 *
 * Menu Panel ItemsView
 *
 **/

Ext.define('TC.view.matrixmenu.DishImageView', {
	extend : 'Ext.Container',
	requires: [ 'TC.store.Dishes' ],
	xtype : 'matrixmenu-dishimageview',
	
	config : {
		cls: 'tcMatrixMenuDishImageView',
		layout: 'vbox',
		listeners: {
			initialize: 'onInitialize'
		},
		
		items:[
		{
			xtype: 'container',
			tpl: '<img src="{large_photo_url}" />',
			cls: 'dish-image',
		},
		{
			xtype: 'container',
			tpl: new Ext.XTemplate(
					'<div class="dish-info-container">',
						'<div class="dish-left">',
							'<div class="dish-name">{name}</div>',
							'<div class="dish-description">{description}</div>',
						'</div>',
						'<div class="dish-right">',
							'<div class="dish-price"><span class="euro">&euro;</span><span class="price">{price:this.twoDecimals}</span></div>',
						'</div>',
					'</div>',
					{
						twoDecimals: function(price) {
							return $tc.formatNumber(price);
						}
					}
			),
			cls: 'dish-info'
		}],
		
	},
	
	onInitialize: function()
	{
		var me = this;
		
		// Data hierarchy
		this.getItems().each(function(item)
		{
			item.setData(me.getData()[0].data);
		});
	}
	
	

});
