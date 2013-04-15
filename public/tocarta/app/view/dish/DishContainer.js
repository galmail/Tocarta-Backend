/**
 * @class TC.view.dish.DishContainer
 * @extends Ext.Panel
 *
 * DishContainer Panel
 * @description This panel display the dish container
 **/

Ext.define('TC.view.dish.DishContainer', {
	requires: ['Ext.tab.Panel','TC.view.dish.DishTitle','TC.view.dish.DishPhoto','TC.view.dish.DishComments','TC.view.dish.DishVideo'],
	extend: 'Ext.Panel',
	xtype: 'dish-container',
	config: {
		layout: 'vbox',
		cls: 'tcDishContainer',
		items: [
			{
				docked: 'top',
				xtype: 'dish-title-toolbar',
			},
			{
				flex: 1,
				xtype: 'tabpanel',
				tabBarPosition: 'bottom',
				layout: {
					animation: 'fade'
				},
				tabBar: {
					cls: 'tcDishContainerTabBar',
					layout: {
						type: 'hbox',
       			pack: 'end',
       			align: 'top'
					}
				},
				items: [
	        {
	        	title: $T.photo,
	        	xtype: 'dish-photo-tab'
	        },
	        {
	          title: $T.comments,
	          xtype: 'dish-comments-tab'
	        },
	        {
	          title: $T.video,
	          xtype: 'dish-video-tab'
	        }
		    ]
	    }
		]
	}
});


