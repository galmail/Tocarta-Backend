/**
 * @class TC.view.survey.slider.SurveyContainer
 * @extends Ext.Panel
 *
 * SurveyContainer Panel
 * @description This panel display the survey
 **/

Ext.define('TC.view.survey.slider.SurveyContainer', {
	requires: [],
	extend: 'Ext.Panel',
	xtype: 'survey-slider-container',
	
	config: {
		cls: 'tcSurveySliderContainer',
		layout: 'vbox',
		items: [
			{
				html: '<h4>survey title</h4>',
				hidden: true,
			},
			{
				flex: 1,
				itemId: 'tcSurveySliderCarouselId',
				xtype: 'carousel',
				items: [
					{ html: 'item1' },
					{ html: 'item2' }
				]
			}
			
		]
	}
	
});
