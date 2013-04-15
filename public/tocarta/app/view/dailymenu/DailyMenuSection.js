/**
 * @class TC.view.dailymenu.DailyMenuSection
 * @extends Ext.Panel
 *
 * DailyMenuSection Panel
 * @description This panel display the daily menu section
 **/

Ext.define('TC.view.dailymenu.DailyMenuSection', {
	requires: ['TC.view.dailymenu.DailyMenuSectionPage'],
	extend: 'Ext.Carousel',
	xtype: 'dailymenu-section',
	config: {
		cls: 'tcDailyMenuSection',
		items: [
			// {
				// xtype: 'toolbar',
				// title: 'Section title',
				// docked: 'top'
			// }
			// all other items
		]
	}
});


