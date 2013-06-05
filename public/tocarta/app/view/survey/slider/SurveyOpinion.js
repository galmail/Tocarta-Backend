/**
 * @class TC.view.survey.SurveyOpinion
 * @extends Ext.Panel
 *
 * SurveyOpinion Panel
 * @description This panel display the survey opinion
 **/

Ext.define('TC.view.survey.slider.SurveyOpinion', {
	extend: 'Ext.Panel',
	xtype: 'survey-opinion',
	config: {
		cls: 'tcSurveyOpinion',
		layout: {
			type: 'vbox',
			align: 'center'
		},
		items: [
			{
				cls: 'tcSurveyOpinionNameContainer',
				html: [
					'<div class="block tcSurveyOpinionName">',
						'<label class="left">'+$T.your_name+'</label>',
						'<input class="right userInputNameField" type="text" name="name" placeholder="'+$T.name_example+'" />',
					'</div>'
				].join('')
			},
			{
				cls: 'tcSurveyOpinionDetailsContainer',
				html: [
					'<div class="block tcSurveyOpinionDetails">',
						'<label class="left">'+$T.your_comment+'</label>',
						'<textarea class="right tcSurveyGeneralOpinion" placeholder="'+$T.leave_your_comment_here+'" rows="4" cols="50"></textarea>',
						// '<input class="right tcSurveyGeneralOpinion" placeholder="'+$T.leave_your_comment_here+'" />',
					'</div>'
				].join('')
			},
			{
				cls: 'tcSurveyOpinionBtn',
				xtype: 'button',
				ui: 'action',
				text: $T.submit
			}
		]
	}
});



