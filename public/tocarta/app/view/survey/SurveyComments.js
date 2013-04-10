/**
 * @class TC.view.survey.SurveyComments
 * @extends Ext.Panel
 *
 * SurveyComments Panel
 * @description This panel display the survey comments
 **/

Ext.define('TC.view.survey.SurveyComments', {
	extend: 'Ext.Panel',
	xtype: 'survey-comments',
	config: {
		cls: 'tcSurveyComments',
		layout: 'hbox',
		items: [
			{
				cls: 'tcSurveyCommentsNameContainer',
				html: [
					'<div class="tcSurveyCommentsName">',
						'<label>'+$T.your_name+'</label>',
						'<input class="userInputNameField" type="text" name="name" placeholder="'+$T.name_example+'" />',
					'</div>'
				].join('')
			},
			{
				cls: 'tcSurveyCommentsDetailsContainer',
				html: [
					'<div class="tcSurveyCommentsDetails">',
						'<label>'+$T.your_comment+'</label>',
						'<input class="tcSurveyGeneralComment" placeholder="'+$T.leave_your_comment_here+'" />',
					'</div>'
				].join('')
			},
			{
				cls: 'tcSurveyCommentsBtn',
				xtype: 'button',
				ui: 'action',
				text: $T.submit
			}
		]
	}
});



