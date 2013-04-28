/**
 * @class TC.view.survey.slider.SurveyPage
 * @extends Ext.DataView
 *
 * SurveyDishes DataView
 * @description This panel display the survey dishes
 **/

Ext.define('TC.view.survey.slider.SurveyPage', {
	// requires: ['TC.view.dailymenu.DailyMenuDish'],
	extend: 'Ext.DataView',
	xtype: 'survey-slider-page',
	config: {
		cls: 'tcSurveySliderPage',
		allowDeselect: true,
		scrollable: false,
		itemTpl: [
			'<div class="tcSurveySliderQuestion">',
			'</div>'
		].join('')
	}
});