/**
 * @class TC.view.filter.FilterView
 * @extends Ext.Panel
 *
 * FilterView Panel
 * @description This panel display the filter options
 **/

Ext.define('TC.view.filter.FilterView', {
	requires: ['TC.store.DishTypes'],
	extend: 'Ext.Panel',
	xtype: 'filter-view',
	
	config: {
		cls: 'tcFilterView',
		floating: true,
		centered: true,
		modal: true,
		hideOnMaskTap: true,
		scrollable: false,
		styleHtmlContent: true,
		items: [
			{
				itemId: 'tcFilterOptionsId',
				cls: 'tcFilterOptions',
				xtype: 'list',
        itemTpl: [
        	'<div class="dish_type_filter">',
        		'<img class="dish_type_icon" src="{small_icon_url}" />',
        		'<div class="dish_type_name">{description}</div>',
        	'</div>'		
        ].join('')
      }
		]
	}
	
	
});
