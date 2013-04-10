/**
 * SurveyQuestions Store
 * 
 */
Ext.define('TC.store.SurveyQuestions', {
    extend  : 'Ext.data.Store',
    requires: ['TC.model.SurveyQuestion'],
    config: {
    	model: 'TC.model.SurveyQuestion'
    }
});
