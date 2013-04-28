/**
 * @class TC.view.survey.SurveyDishes
 * @extends Ext.DataView
 *
 * SurveyDishes DataView
 * @description This panel display the survey dishes
 **/

Ext.define('TC.view.survey.basic.SurveyDishes', {
	extend: 'Ext.DataView',
	xtype: 'survey-dishes',
	
	config: {
		cls: 'tcSurveyDishes',
		layout: 'hbox',
		scrollable: 'horizontal',
		itemTpl: [
			'<tpl if="thumbnail_photo_url.length &gt; 0">',
			'<div id="dish_eaten_{dish_id}" class="dish_eaten">',
				'<div class="rating">',
      		'<div class="star"></div>',
      		'<div class="star"></div>',
      		'<div class="star"></div>',
      		'<div class="star"></div>',
      		'<div class="star"></div>',
      	'</div>',
				'<img class="dish_photo" src="{thumbnail_photo_url}" />',
				'<textarea class="survey_dish_comment" placeholder="'+$T.drop_a_line_on+'<br/>{item_name}"></textarea>',
			'</div>',
			'</tpl>'
   	].join('')
	}
	
});
