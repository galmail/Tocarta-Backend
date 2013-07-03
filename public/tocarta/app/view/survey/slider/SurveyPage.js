/**
 * @class TC.view.survey.slider.SurveyPage
 * @extends Ext.DataView
 *
 * SurveyDishes DataView
 * @description This panel display the survey dishes
 **/

Ext.define('TC.view.survey.slider.SurveyPage', {
	// requires: ['TC.view.dailymenu.DailyMenuDish'],
	// extend: 'Ext.DataView',
	extend: 'Ext.Panel',
	xtype: 'survey-slider-page',
	config: {
		cls: 'tcSurveySliderPage',
		firstPage: true,
		layout: {
			type: 'vbox',
			align: 'center'
		},
		items: [
			{
				xtype: 'button',
				text: 'Back',
				hidden: true,
				handler: function(){
					this.parent.parent.previous();
				}
			},
			{
				xtype: 'button',
				text: $T.next,
				handler: function(){
					this.parent.parent.next();
				}
			}
		]
	}
});