/**
 * @class TC.controller.Order
 * @extends Ext.app.Controller
 * 
 * The Order Controller
 * @description controls the order view
 */
Ext.define('TC.controller.Order', {
  extend: 'Ext.app.Controller',
  //requires: ['TC.store.Images'],
  config: {
  	routes: {
      
    },
    views: [
    	'order.OrderView'
    ],   
    refs: {
    	order: 'order-view',
    	submitOrderButton: 'order-view #tcOrderButtonId',
    	totalView: 'order-view #tcOrderTotalId',
    	emptyOrderMsg: 'order-view #tcEmptyOrderMsgId'
    },
    control: {
    	order: { initialize: 'initOrder' },
    	submitOrderButton: { tap: 'submitOrder' }
    }
  },
  
  initOrder: function(){
  	console.log('TC.controller.Order.initOrder');
  	var me = this;
  	// lets bind stuff
  	$z(document).on($tc.click, '.tcOrderView .tcOrderDataView .remove-dish-icon', me.removeItem);
  	$z(document).on($tc.click, '.tcOrderView .tcOrderDataView .toggle-combo-icon', me.toggleComboItem);
  	this._updateOrderSizeWindow();
  },
  
  launch: function(){
  	console.log('TC.controller.Order.launch');
  	this._updateOrderView();
  },
  
  submitOrder: function(){
  	console.log('TC.controller.Order.submitOrder');
  	var me = this;
  	// $tc.confirmMsg($T.order_question,function(btnPressed){
  		// if(btnPressed == 'yes'){
  			// set mask on order
  			me.getOrder().setMasked({xtype: 'loadmask',message: $T.order_loading});
  			// hide this dialog
  			TC.LastOrder.setProxy({
  				type: $tc.protocol,
  				url: $tc.url('send_order_url') + '?key=' + TC.Setting.get('key'),
  				writer: {
		    		type: 'json',
		    		root: 'order'
		    	},
		    	timeout: $tc.timeout
  			});
  			TC.LastOrder.save({
  				success: function(lastOrder,request){
  					me.getOrder().unmask();
  					me.getOrder().hide();
  					if(request.getResponse().status==200){
  						// remove mask and hide order
		  				TC.LastOrder.clearOrder();
		  				TC.showMsg($T.order_confirmation,'success');
  					}
  					else {
  						TC.showMsg($T.comm_error,'error');
  					}
  				},
  				failure: function(){
  					me.getOrder().unmask();
  					me.getOrder().hide();
  					TC.showMsg($T.comm_error,'error');
  				}
  			});
  		// }
  	// });
  },
  
  removeItem: function(event){
  	console.log('TC.controller.Order.removeItem');
  	var itemId = event.target.parentElement.id.split('-').reverse()[0];
  	TC.LastOrder.removeItem(itemId);
  },
  
  toggleComboItem: function(event){
  	console.log('TC.controller.Order.toggleComboItem');
  	$z(event.target).closest('.order-item').find('.combo-dishes').toggle();
  },
  
  _updateOrderSizeWindow: function(){
		console.log('TC.controller.Order._updateOrderSizeWindow');
		var me = this;
		// update window size
		this.getOrder().down('dataview').setHeight(me._calculateHeight());
		// listen for 
		TC.LastOrder.setListeners({
			adding_dish: function(){
				console.log('adding_dish received, updating order size window.');
				// update window size
				me.getOrder().down('dataview').setHeight(me._calculateHeight());
			},
			removing_dish: function(){
				console.log('removing_dish received, updating order size window.');
				// update window size
				me.getOrder().down('dataview').setHeight(me._calculateHeight());
			},
			clearing_order: function(){
				console.log('clearing_order received, updating order size window.');
				// update window size
				me.getOrder().down('dataview').setHeight(me._calculateHeight());
			}
		});
	},
	
	_updateOrderView: function(){
		console.log('TC.controller.Order._updateOrderView');
		var me = this;
		TC.LastOrder.setListeners({
			adding_dish: function(){
				console.log('adding_dish received, updating order view.');
				me.getSubmitOrderButton().show();
				me.getTotalView().show();
				me.getEmptyOrderMsg().hide();
			},
			removing_dish: function(){
				if(TC.LastOrder.order_items().getCount()==0){
					console.log('removing_dish received, updating order view.');
					me.getSubmitOrderButton().hide();
					me.getTotalView().hide();
					me.getEmptyOrderMsg().show();
				}
			},
			clearing_order: function(){
				console.log('clearing_order received, updating order view.');
				me.getSubmitOrderButton().hide();
				me.getTotalView().hide();
				me.getEmptyOrderMsg().show();
			}
		});
	},
	
	_calculateHeight: function(){
		console.log('TC.controller.Order._calculateHeight');
		var totalHeight = 0;
		var miniLineHeight = 18;
		var singleLineHeight = 49;
		var doubleLineHeight = 79;
		TC.LastOrder.order_items().each(function(orderItem){
			var s1 = orderItem.get('item_name').indexOf('<br/>');
			var s2 = orderItem.get('item_name').indexOf('<br>');
			if(s1>=0 || s2>=0){
				console.log('found double line');
				totalHeight += doubleLineHeight;
			}
			else {
				totalHeight += singleLineHeight;
			}
			// update height for combo stuff
			if(orderItem.combo_dishes() && orderItem.combo_dishes().getCount()>0){
				totalHeight += (miniLineHeight * orderItem.combo_dishes().getCount());
			}
		});
		if(totalHeight > 400) totalHeight = 400;
		return totalHeight;
	}
  
});
