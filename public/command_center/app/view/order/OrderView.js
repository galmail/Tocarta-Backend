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
	requires: ['Ext.dataview.DataView'],
	config: {
		cls: 'tcOrderView',
		// floating: true,
		centered: true,
		modal: true,
		hideOnMaskTap: false,
		scrollable: false,
		styleHtmlContent: true,
		layout: 'vbox',
		items : [
			{
				id: 'tcOrderToolbarId',
				docked: 'top',
				xtype: 'toolbar',
				// title: 'Pedido Mesa X',
				items: [
					// { xtype: 'spacer' },
					{
						id: 'tcCloseOrderBtnId',
						xtype: 'button',
						text: $TO.close,
						handler: function(){
							this.parent.parent.hide();
						}
					}
				]
			},
			{
				flex: 1,
				id: 'tcOrderDataViewId',
				xtype: 'dataview',
				cls: 'tcOrderDataView',
        itemTpl: new Ext.XTemplate(
	    		'<div class="order-item" id="order-item-{id}">',
	      		'<div class="dish-quantity">{quantity}</div>',
	      		'<div class="dish-name">',
	      			'<div class="dish-name-title">{name}</div>',
	      			'<div class="combo-dishes">',
		      			'<tpl for="combo_dishes">',
		      				'<div class="combo-dish-title">{name}</div>',
		      			'</tpl>',
	      			'</div>',
	      		'</div>',
	    		'</div>'
        )
			}
		]
	}
	
	
});
