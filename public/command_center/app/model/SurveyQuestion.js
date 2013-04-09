/**
 * SurveyQuestion Class
 *
 */

Ext.define('TC.model.SurveyQuestion', {
	extend : 'Ext.data.Model',
	config: {
		fields: [
	    {name: "id", type: "int"},
	    {name: "name", type: "string"},
	    {name: "description", type: "string"}
	  ],
	  associations: [
	  	{type: 'belongsTo', model: 'TC.model.Restaurant', name: 'restaurant'},
	    {type: 'hasMany', model: 'TC.model.Comment', name: 'comments'}
	  ]
	}
});
