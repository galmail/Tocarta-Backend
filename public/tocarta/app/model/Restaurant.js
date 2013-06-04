/**
 * Restaurant Class
 *
 */

Ext.define('TC.model.Restaurant', {
	extend : 'Ext.data.Model',
	requires: ['TC.model.Menu','TC.model.Banner','TC.model.SurveyQuestion'],
	config: {
		fields: [
	    {name: "id", type: "int"},
	    {name: "name", type: "string"},
	    {name: "num_tables", type: "string"},
	    {name: "setting", persist: true},
	    {name: "menus", persist: true},
	    {name: "banners", persist: true},
	    {name: "survey_questions", persist: true},
	    {name: "logo", type: "string"},
	    {name: "logo_url", type: "string",
	    	convert: function(value, record){
	    		return $tc.checkImgUrl(record.get("logo"));
	    	}
	    },
	    {name: "bg", type: "string"},
	    {name: "bg_url", type: "string",
	    	convert: function(value, record){
	    		return $tc.checkImgUrl(record.get("bg"));
	    	}
	    },
	    {name: "i18nbg", type: "string"},
	    {name: "i18nbg_url", type: "string",
	    	convert: function(value, record){
	    		return $tc.checkImgUrl(record.get("i18nbg"));
	    	}
	    },
	  ],
	  associations: [
	    {type: 'hasMany', model: 'TC.model.Menu', name: 'menus'},
	    {type: 'hasMany', model: 'TC.model.Banner', name: 'banners'},
	    {type: 'hasMany', model: 'TC.model.SurveyQuestion', name: 'survey_questions'}
	  ],
	  localProxy: {
			type: 'localstorage',
			id  : 'restaurant'
		}
	},
	
	getMainMenu: function(){
  	var pos = this.menus().findBy(function(record,id){
  		return (record.get('menu_type')=='main');
  	});
  	return this.menus().getAt(pos);
	},
	
	getDailyMenu: function(){
  	var pos = this.menus().findBy(function(record,id){
  		return (record.get('menu_type')=='daily');
  	});
  	return this.menus().getAt(pos);
	},
	
	getDessertsMenu: function(){
  	var pos = this.menus().findBy(function(record,id){
  		return (record.get('menu_type')=='desserts');
  	});
  	return this.menus().getAt(pos);
	},
	
	getBeveragesMenu: function(){
  	var pos = this.menus().findBy(function(record,id){
  		return (record.get('menu_type')=='beverages');
  	});
  	return this.menus().getAt(pos);
	}
	
	
});
