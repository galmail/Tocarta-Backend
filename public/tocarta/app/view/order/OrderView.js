/**
 * @class TC.view.order.OrderView
 * @extends Ext.Panel
 *
 * OrderView Panel
 * @description This panel display the order
 **/

Ext.define('TC.view.order.OrderView', {
	extend: 'Ext.Panel',
	xtype: 'order-view',
	
	config: {
		cls: 'tcOrderView',
		floating: true,
		centered: true,
		modal: true,
		hideOnMaskTap: true,
		scrollable: false,
		styleHtmlContent: true,
		layout: {
			type: 'vbox',
			// align: 'stretch'
		},
		items: [
			{
				docked: 'top',
				xtype: 'toolbar',
				title: $T.order,
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
				id: 'tcOrderDataViewId',
				xtype: 'dataview',
				cls: 'tcOrderDataView',
        itemTpl: new Ext.XTemplate(
	    		'<div class="order-item" id="order-item-{id}">',
	      		'<div class="dish-quantity">{quantity}</div>',
	      		'<div class="dish-name">',
	      			'<div class="dish-name-title">{item_name}</div>',
	      			'<tpl if="combo_id"><div class="toggle-combo-icon">(mas)</div></tpl>',
	      		'</div>',
	      		'<div class="remove-dish-icon"></div>',
	      		'<div class="dish-total"><span class="euro">€</span><span class="total-per-item">{total:this.twoDecimals}</span></div>',
	      		'<tpl if="combo_id">',
	      			'<div class="combo-dishes">',
			    			'<tpl for="combo_dishes">',
			    				'<div class="combo-dish-name">{name:this.oneLineIt}</div>',
			    			'</tpl>',
		    			'</div>',
		    		'</tpl>',
	    		'</div>',
        {
        	twoDecimals: function(total){
						return $tc.formatNumber(total);
					},
					oneLineIt: function(name){
						return name.replace("<br>"," ").replace("<br/>"," ");
					}
        })
			},
			{
				itemId: 'tcOrderTotalId',
				cls: 'tcOrderTotal',
				hidden: true,
				tpl: new Ext.XTemplate(
					'<div class="total-order">',
						'<div class="text">Total</div>',
						'<div class="order-total-euros">',
							'<span class="euro">€</span>',
							'<span class="num">{total:this.twoDecimals}</span>',
						'</div>',
					'</div>',
				{
					twoDecimals: function(total) {
						return $tc.formatNumber(total);
					}
				})
			},
			{
				itemId: 'tcOrderButtonId',
				cls: 'tcOrderBtn',
				hidden: true,
				xtype: 'button',
				text: $T.order_now
			},
			{
				itemId: 'tcEmptyOrderMsgId',
				cls: 'tcEmptyOrderMsg',
				html: $T.order_is_empty
			}
		]
	},
	
	initialize: function() {
		console.log('TC.view.order.OrderView initialize');
		// load store
		this.down('#tcOrderDataViewId').setStore(TC.LastOrder.order_items());
		this.down('#tcOrderTotalId').setRecord(TC.LastOrder);
		this.callParent(arguments);
	}
	
	
});
