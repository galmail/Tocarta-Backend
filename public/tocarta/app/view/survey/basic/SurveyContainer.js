/**
 * @class TC.view.survey.SurveyContainer
 * @extends Ext.Panel
 *
 * SurveyContainer Panel
 * @description This panel display the survey
 **/

Ext.define('TC.view.survey.basic.SurveyContainer', {
	requires: ['TC.view.survey.basic.SurveyDishes','TC.view.survey.basic.SurveyQuestions','TC.view.survey.basic.SurveyComments'],
	extend: 'Ext.Panel',
	xtype: 'survey-container',
	
	config: {
		cls: 'tcSurveyContainer',
		scrollable: false,
		items: [
			{ cls: 'tcSurveyTitle tcSurveyTitleDishes', html: '<div>'+$T.comment_dishes_eaten+'</div>' },
			{ itemId: 'tcSurveyDishesId', xtype: 'survey-dishes' },
			{ cls: 'tcSurveyTitle', html: '<div>'+$T.your_opinion+'</div>' },
			{ xtype: 'survey-questions' },
			{ cls: 'tcSurveyTitle', html: '<div>'+$T.your_name_and_comment+'</div>' },
			{ xtype: 'survey-comments' }
		]
	}
	
});
