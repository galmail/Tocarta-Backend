/**
 * Comment Class
 * 
 */

Ext.define('TC.model.Comment', {
	extend: 'Ext.data.Model',
	config: {
		fields: [
      {name: "id", type: "int"},
      {name: "dish_id", type: "int"},
      {name: "survey_question_id", type: "int"},
      {name: "name", type: "string"},
      {name: "description", type: "string"},
      {name: "rating", type: "int"}
	  ],
	  associations: [
      //{type: 'belongsTo', model: 'TC.model.Dish', name: 'dish'}
      //{type: 'belongsTo', model: 'TC.model.SurveyQuestion', name: 'surveyQuestion'}
	  ]
	}
});
