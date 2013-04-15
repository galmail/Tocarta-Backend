/**
 * @class TC.view.dailymenu.DailyMenuSectionPage
 * @extends Ext.Panel
 *
 * DailyMenuSectionPage Panel
 * @description This panel displays dishes in one page
 **/

Ext.define('TC.view.dailymenu.DailyMenuSectionPage', {
	// requires: ['TC.view.dailymenu.DailyMenuDish'],
	extend: 'Ext.DataView',
	xtype: 'dailymenu-sectionpage',
	config: {
		cls: 'tcDailyMenuSectionPage',
		allowDeselect: true,
		scrollable: false,
		itemTpl: [
			'<div class="tcDailyMenuDish">',
				'<img class="tcDailyMenuDishPhoto" src="{large_photo_url}" />',
				'<div class="tcDailyMenuDishText">',
					'<div class="tcDailyMenuDishTitle">{name}</div>',
					'<div class="tcDailyMenuDishDescription">{description}</div>',
				'</div>',
			'</div>'
		].join('')
	}
});


