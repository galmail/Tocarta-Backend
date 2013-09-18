/**
 * Menu Class
 *
 */

Ext.define('TC.model.Menu', {
	extend : 'Ext.data.Model',
	requires: ['TC.model.Section','TC.model.Dishtype'],
	config: {
		fields: [
	    {name: "id", type: "int"},
	    {name: "lang", type: "string"},
	    {name: "sections", persist: true},
	    {name: "name", type: "string"},
	    {name: "stylesheet", type: "string"},
	    {name: "stylesheet_url", type: "string",
	    	convert: function(value, record){
	    		return $tc.checkImgUrl(record.get("stylesheet"));
	    	}
	    },
	    {name: "menu_type", type: "string"},
	    {name: "theme", type: "string"},
	    {name: "price", type: "float"},
	    {name: "valid_from_hour", type: "float"},
	    {name: "valid_till_hour", type: "float"},
	    {name: "valid_days", type: "string"}
	  ],
	  associations: [
	  	{type: 'belongsTo', model: 'TC.model.Restaurant', name: 'restaurant'},
	  	{type: 'hasMany', model: 'TC.model.Dishtype', name: 'dishtypes'},
	    {type: 'hasMany', model: 'TC.model.Section', name: 'sections'}
	  ]
	},
	
	getDishesByType: function(dishType){
		console.log('TC.model.Menu.dishes');
		var me = this;
		me.all_dishes = Ext.create('TC.store.Dishes');
		this.sections().each(function(section){
			section.dishes().each(function(dish){
				if(dish.dishtypes().find('name',dishType)>=0)
					me.all_dishes.add(dish);
			});
			section.subsections().each(function(subsection){
				subsection.dishes().each(function(dish){
					if(dish.dishtypes().find('name',dishType)>=0)
						me.all_dishes.add(dish);
				});
			});
		});
		return me.all_dishes;
	}
	
});
