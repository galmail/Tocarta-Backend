/**
 * @class TC.view.dish.DishNutritionFacts
 * @extends Ext.Panel
 *
 * DishNutritionFacts Panel
 * @description This panel displays the dish nutrition facts
 **/

Ext.define('TC.view.dish.DishNutritionFacts', {
	extend: 'Ext.Panel',
	xtype: 'dish-nutritionfacts-tab',
	config: {
		cls : 'tcDishNutritionFacts',
		items: [
			{
				itemId: 'tcDishNutritionFactsDataItemsId',
				tpl: new Ext.XTemplate(
		    	'<div class="dish-nutritionfacts">',
			    	'<div class="block dish-nutritionfacts-calories">',
			    		'<div class="label">'+$T.calories+' (kcal):</div>',
			    		'<div class="graph"><div class="graph-bar" style="width: 100%;">{calories}</div></div>',
		    		'</div>',
		    		'<div class="block dish-nutritionfacts-proteins">',
			    		'<div class="label">'+$T.proteins+' (gr):</div>',
			    		'<div class="graph"><div class="graph-bar" style="width: {calories:this.proteins_percentage(values.proteins)}%;">{proteins}</div></div>',
		    		'</div>',
		    		'<div class="block dish-nutritionfacts-fats">',
			    		'<div class="label">'+$T.fats+' (gr):</div>',
			    		'<div class="graph"><div class="graph-bar" style="width: {calories:this.fat_percentage(values.fats)}%;">{fats}</div></div>',
		    		'</div>',
		    		'<div class="block dish-nutritionfacts-carbs">',
			    		'<div class="label">'+$T.carbs+' (gr):</div>',
			    		'<div class="graph"><div class="graph-bar" style="width: {calories:this.carbs_percentage(values.carbs)}%;">{carbs}</div></div>',
		    		'</div>',
		    		// '<div class="block">',
		    			// '<div class="label">Total:</div>',
				    	// '<div class="graph">',
				    		// '<div class="graph-bar fats" style="width: {calories:this.fat_percentage(values.fats)}%;">{fats}</div>',
				    		// '<div class="graph-bar carbs" style="width: {calories:this.carbs_percentage(values.carbs)}%;">{carbs}</div>',
				    		// '<div class="graph-bar proteins" style="width: {calories:this.proteins_percentage(values.proteins)}%;">{proteins}</div>',
				    	// '</div>',
			    	// '</div>',
		  		'</div>',
		  		{
		  			fat_percentage: function(cal,fats){
							return Math.floor(((fats*9)/(cal))*100);
						},
						carbs_percentage: function(cal,carbs){
							return Math.floor(((carbs*4)/(cal))*100);
						},
						proteins_percentage: function(cal,proteins){
							return Math.floor(((proteins*4)/(cal))*100);
						},
						perc: function(calories,other){
							return Math.ceil(other*100/calories);
						}
					}
		  		)
			}
		]
	}
});