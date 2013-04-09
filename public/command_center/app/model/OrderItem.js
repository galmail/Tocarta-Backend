/**
 * OrderItem Class
 *
 */

Ext.define('TC.model.OrderItem', {
	extend : 'Ext.data.Model',
	requires: ['TC.model.Combo'],
	config: {
		fields: [
	    {name: "id", type: "int"},
	    // {name: "order_id", type: "int"},
	    // {name: "combo_id", type: "int"},
	    {name: "combo", persist: true},
	    {name: "dish_id", type: "int"},
	    {name: "name", type: "string"},
	    {name: "item_name", type: "string"},
	    {name: "item_price", type: "float"},
	    {name: "quantity", type: "int"},
	    {name: "total", type: "float"},
	    {name: "thumbnail", type: "string"},
	    {name: "thumbnail_photo_url", type: "string",
	    	convert: function(value, record){
	    		return $tc.getUri() + record.get("thumbnail");
	    	}
	    }
	  ],
	  associations: [
	    {type: 'belongsTo', model: 'TC.model.Order', name: 'order'},
	    {type: 'belongsTo', model: 'TC.model.Dish', name: 'dish'},
	    {type: 'belongsTo', model: 'TC.model.Combo', name: 'combo'},
	    {type: 'hasMany', model: 'TC.model.Dish', name: 'combo_dishes'}
	  ]
	},

	setupCombo: function(){
		if(!this.data.combo) return;
		var combo = this.getCombo();
		var me = this;
		if(combo){
			this.set('name',combo.get('name'));
			this.combo_dishes().removeAll(true);
			combo.dishes().each(function(dish){
				me.combo_dishes().add(dish);
			});
		}
  }


});
