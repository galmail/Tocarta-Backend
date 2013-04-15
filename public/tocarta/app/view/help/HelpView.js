/**
 * @class TC.view.help.HelpView
 * @extends Ext.Panel
 *
 * HelpView Panel
 * @description This panel display the help view
 **/

Ext.define('TC.view.help.HelpView', {
	extend: 'Ext.Panel',
	xtype: 'help-view',
	
	config: {
		cls: 'tcHelpView',
		modal: true,
		hideOnMaskTap: true,
		centered: true,
		padding: 5,
		styleHtmlContent: true,
		scrollable: 'vertical',
		items: [
			{
				docked: 'top',
				xtype: 'toolbar',
				title: $T.information,
				items: [
					{
						itemId: 'closeBtnId',
						xtype: 'button',
						text: $T.close,
						handler: function(){
							this.parent.parent.hide();
						}
					}
				]
			},
			{
				defaults: {
					cls: 'tcHelpViewBtnRow',
					layout: {
						type: 'hbox',
						align: 'center'
					}
				},
				items: [
					{
						items: [
							{
								xtype: 'button',
								cls: 'ilustrationButton',
								iconMask: true,
				    		iconCls: 'home'
							},
							{
								html: [
									'<div class="tcTitleLine">'+$T.home_button_title+'</div>',
									'<div class="tcTextLine">'+$T.home_button_explanation+'</div>'
								].join('')
							}
						]
					},
					{
						items: [
							{
								xtype: 'button',
								cls: 'ilustrationButton',
								iconMask: true,
				    		iconCls: 'waiter'
							},
							{
								html: [
									'<div class="tcTitleLine">'+$T.waiter_button_title+'</div>',
									'<div class="tcTextLine">'+$T.waiter_button_explanation+'</div>'
								].join('')
							}
						]
					},
					{
						items: [
							{
								xtype: 'button',
								cls: 'ilustrationButton',
								iconMask: true,
				    		iconCls: 'bill'
							},
							{
								html: [
									'<div class="tcTitleLine">'+$T.bill_button_title+'</div>',
									'<div class="tcTextLine">'+$T.bill_button_explanation+'</div>'
								].join('')
							}
						]
					},
					{
						items: [
							{
								xtype: 'button',
								cls: 'ilustrationButton tcOrderBtn',
								iconMask: true,
				    		iconCls: 'order',
				    		badgeText: 7
							},
							{
								html: [
									'<div class="tcTitleLine">'+$T.order_button_title+'</div>',
									'<div class="tcTextLine">'+$T.order_button_explanation+'</div>'
								].join('')
							}
						]
					}
				]
			},
			{
				xtype: 'fieldset',
				cls: 'tcLegend',
				layout: {
					type: 'hbox'
					// pack: 'center'
				},
				items: [
					{
						flex: 1,
						cls: 'tcDishType',
						html: [
							'<img src="http://s3.amazonaws.com/tocarta-prod/common/img/dish_types/big_icon/dish_type_1.png">',
							'<div class="dish_type_name">'+ $T.veg_icon_explanation +'</div>'
						].join('')
					},
					{
						flex: 1,
						cls: 'tcDishType',
						html: [
							'<img src="http://s3.amazonaws.com/tocarta-prod/common/img/dish_types/big_icon/dish_type_2.png">',
							'<div class="dish_type_name">'+ $T.spicy_icon_explanation +'</div>'
						].join('')
					}
				]
			},
			{
				cls: 'tcHelpViewFootnote',
				html: [
					'<div class="left">'+$T.app_copyright+'</div>',
					'<div class="right">'+$T.tocarta_website+'</div>'
				].join('')
			}
		]
	}
	
});
