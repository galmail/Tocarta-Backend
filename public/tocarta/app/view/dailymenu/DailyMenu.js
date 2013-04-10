/**
 * @class TC.view.dailymenu.DailyMenu
 * @extends Ext.Panel
 *
 * Daily Menu Panel
 * @description This panel displays the daily menu
 **/

Ext.define('TC.view.dailymenu.DailyMenu', {
	extend: 'Ext.Panel',
	requires: ['TC.view.dailymenu.DailyMenuSection'],
	xtype: 'daily-menu',
	config: {
		cls: 'tcDailyMenu',
		layout: 'vbox',
		items: [
			{
				cls : 'tcDailyMenuTitle',
				layout: {
					type: 'hbox',
					pack: 'start',
					align: 'center'
				},
				items: [
					{
						itemId: 'tcDailyMenuTitleId',
						tpl: new Ext.XTemplate(
							'<div class="tcDailyMenuTitleText">',
								'<div>{name}</div>',
								'<div> - € {price:this.twoDecimals}</div>',
							'</div>',
						{
							twoDecimals: function(price) {
								return $tc.formatNumber(price);
							}
						})
		     	},
		     	{ xtype: 'spacer' },
		     	{
		     		itemId: 'tcDailyMenuAddBtnId',
		     		cls: 'tcDailyMenuAddBtn',
		     		xtype: 'button',
		     		text: $T.add_menu
		     	}
				]
			},
			{
				flex: 1,
				xtype: 'tabpanel',
				tabBarPosition: 'top', //bottom
				layout: {
					animation: 'fade'
				},
				tabBar: {
					cls: 'tcDailyMenuTabBar',
					layout: {
						type: 'hbox',
       			pack: 'start', //end
       			align: 'top'
					},
					defaults: {
						badgeText: ' ' 
					}
				}
	    }
		]
	}
});
