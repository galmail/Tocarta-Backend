/**
 * @class TC.view.survey.SurveyQuestions
 * @extends Ext.DataView
 *
 * SurveyQuestions DataView
 * @description This panel display the survey questions
 **/

Ext.define('TC.view.survey.basic.SurveyQuestions', {
	extend: 'Ext.DataView',
	xtype: 'survey-questions',
	
	config: {
		cls: 'tcSurveyQuestions',
		scrollable: false,
		itemTpl: [
      '<div id="survey_question_{id}" class="survey_question">',
      	'<div class="question_title">{description}</div>',
      	'<tpl if="yes_no_type==true">',
      		'<div class="x-container x-segmentedbutton x-layout-box-item x-stretched" style="float:right;margin-top:8px;margin-right: 5px;">',
	      		'<div class="x-inner x-segmentedbutton-inner x-horizontal x-align-stretch x-pack-start x-layout-box">',
		      		'<div style="float:left;" class="x-button-normal x-button x-layout-box-item x-stretched x-first">',
			      		'<span style="display: none;" class="x-badge"></span>',
			      		'<span class="x-button-icon" style="display: none;"></span>',
			      		'<span style="" class="x-button-label">'+$T.yes_button+'</span>',
		      		'</div>',
							'<div style="float:left;" class="x-button-normal x-button x-layout-box-item x-stretched">',
								'<span style="display: none;" class="x-badge"></span>',
								'<span class="x-button-icon" style="display: none;"></span>',
								'<span style="" class="x-button-label">'+$T.maybe_button+'</span>',
							'</div>',
							'<div style="float:left;" class="x-button-normal x-button x-layout-box-item x-stretched x-last">',
								'<span style="display: none;" class="x-badge"></span>',
								'<span class="x-button-icon" style="display: none;"></span>',
								'<span style="" class="x-button-label">'+$T.no_button+'</span>',
							'</div>',
						'</div>',
					'</div>',
				'</tpl>',
				'<tpl if="yes_no_type==false">',
      	'<div class="rating">',
      		'<div class="star"></div>',
      		'<div class="star"></div>',
      		'<div class="star"></div>',
      		'<div class="star"></div>',
      		'<div class="star"></div>',
      	'</div>',
      	'</tpl>',
      '</div>'
		].join('')
	}
	
});
