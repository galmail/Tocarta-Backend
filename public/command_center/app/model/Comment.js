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
	
	// send: function(callback){
  	// if(localStorage["TC_OFFLINE"]){
			// setTimeout(function(){ if(callback) callback(true); },1000);
			// return true;
		// }
  	// $j.getJSON(localStorage["TC_BASE_URL"] + "/cli/c/send_comment.json?key="+localStorage["TABLET_KEY"],this.data,function(data){
			// if(callback){
				// callback(data.result);
			// }
		// });
  // }
    
});
