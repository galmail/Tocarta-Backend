/**
 * Order Class
 *
 */

Ext.define('TC.model.Order', {
	extend : 'Ext.data.Model',
	requires: ['TC.model.OrderItem'],
	config: {
	  fields: [
	    {name: "id", type: "int"},
	    {name: "name", type: "string", defaultValue: 'order_name'},
	    {name: "language", type: "string"},
	    {name: "order_items", persist: true},
	    {name: "total", type: "float", defaultValue: 0},
	    {name: "table", type: "int"}
	  ],
	  associations: [
	    {type: 'hasMany', model: 'TC.model.OrderItem', name: 'order_items'}
	  ]
	},
	
	addItem: function(dish){
		var me = this;
		var orderItem = this.order_items().findRecord('dish_id',dish.getId());
		if(orderItem){
			// update items quantity
			var new_quantity = orderItem.get('quantity')+1;
			orderItem.set('quantity',new_quantity);
			// update items total
			var new_total = orderItem.get('item_price')*new_quantity;
			orderItem.set('total',new_total.toFixed(2));
			// update orders total
			this._updateTotal(orderItem.get('item_price'));
		}
		else {
			var newOrderItem = Ext.create('TC.model.OrderItem',{
				id: me.order_items().getCount()+1,
    		dish_id: dish.getId(),
    		item_name: dish.get('name'),
    		item_price: dish.get('price'),
    		quantity: 1,
    		total: dish.get('price')
			});
			this.order_items().add(newOrderItem);
			// update orders total
			this._updateTotal(newOrderItem.get('item_price'));
		}
	},
	
	removeItem: function(item_id){
		console.log('TC.model.Order.removeItem ' + item_id);
		var order_item = this.order_items().findRecord('id',item_id);
  	this._updateTotal(order_item.get('item_price')*(-1));
  	if(order_item.get('quantity')>1){
  		// update the item from store
  		var new_quantity = order_item.get('quantity')-1;
  		var new_total = order_item.get('item_price')*new_quantity;
  		order_item.set('quantity',new_quantity);
  		order_item.set('total',new_total.toFixed(2));
  	}
  	else {
  		// remove the item from store
  		this.order_items().remove(order_item);
  	}
	},
	
	clearOrder: function(){
		// remove order_items and clear total
		this.order_items().removeAll();
		this.set('total',0);
	},	
	
	///// private functions /////
	
	_updateTotal: function(price_change){
		var total = this.get('total')+price_change;
		this.set('total',total.toFixed(2));
	}


});
