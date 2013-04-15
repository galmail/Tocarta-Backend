/**
 * @class TC.view.dish.DishTitle
 * @extends Ext.Toolbar
 *
 * DishTitle Toolbar
 * @description This panel display the dish title
 **/

Ext.define('TC.view.dish.DishTitle', {
	extend: 'Ext.Toolbar',
	xtype: 'dish-title-toolbar',
	config: {
		cls : 'tcDishTitle',
		layout: {
			type: 'hbox',
			pack: 'start'
		},
		items: [
			{
				itemId: 'tcDishTitleId',
        xtype: 'title'
     	},
     	{
     		itemId: 'tcDishTitleIconsId',
     		cls: 'tcDishTitleIcons',
     		xtype: 'dataview',
     		itemTpl: [
     			'<img src="{big_icon_url}" />'
     		].join('')
     	}
		]
	}
});