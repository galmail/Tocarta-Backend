/**
 * @class TC.view.survey.SurveyView
 * @extends Ext.Panel
 *
 * SurveyView Panel
 * @description This panel display the survey as modal
 **/

Ext.define('TC.view.survey.SurveyView', {
	extend: 'Ext.Panel',
	xtype: 'survey-view',
	
	config: {
		cls: 'tcSurveyView',
		floating: true,
		centered: true,
		modal: true,
		hideOnMaskTap: true,
		scrollable: false,
		styleHtmlContent: true,
		layout: {
			type: 'vbox',
			// align: 'stretch'
		},
		items: [
			{
				docked: 'top',
				xtype: 'toolbar',
				title: $T.survey,
				items: [
					{
						itemId: 'closeBtnId',
						xtype: 'button',
						text: $T.close,
						handler: function(){
							this.parent.parent.hide();
						}
					}
				]
			},
			{
				html: "here goes the survey"
			}
		]
	}
	
	
});
