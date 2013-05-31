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
			    	'<div class="dish-nutritionfacts-calories">',
			    		'<span class="label">calories:</span>',
			    		'<span class="val">{calories}</span>',
		    		'</div>',
		    		'<div class="dish-nutritionfacts-fats">',
			    		'<span class="label">fats:</span>',
			    		'<span class="val">{fats}</span>',
		    		'</div>',
		    		'<div class="dish-nutritionfacts-carbs">',
			    		'<span class="label">carbs:</span>',
			    		'<span class="val">{carbs}</span>',
		    		'</div>',
		    		'<div class="dish-nutritionfacts-proteins">',
			    		'<span class="label">proteins:</span>',
			    		'<span class="val">{proteins}</span>',
		    		'</div>',
		  		'</div>')
			}
		]
	}
});