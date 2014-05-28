/**
 * Restaurant Class
 *
 */

Ext.define('TC.model.Restaurant', {
	extend : 'Ext.data.Model',
	requires: ['TC.model.Menu','TC.model.Banner','TC.model.Agreement','TC.model.SurveyQuestion'],
	config: {
		fields: [
	    {name: "id", type: "int"},
	    {name: "name", type: "string"},
	    {name: "num_tables", type: "string"},
	    {name: "current_locale", type: "string"},
	    {name: "setting", persist: true},
	    {name: "menus", persist: true},
	    {name: "banners", persist: true},
	    {name: "agreements", persist: true},
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
	    {type: 'hasMany', model: 'TC.model.Agreement', name: 'agreements'},
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
	},
	
	getCocktailsMenu: function(){
	  	var pos = this.menus().findBy(function(record,id){
	  		return (record.get('menu_type')=='cocktails');
	  	});
	  	return this.menus().getAt(pos);
	},
	
	getWinesMenu: function(){
	  	var pos = this.menus().findBy(function(record,id){
	  		return (record.get('menu_type')=='wines');
	  	});
	  	return this.menus().getAt(pos);
	},
	
	getSpecialMenu: function(){
	  	var pos = this.menus().findBy(function(record,id){
	  		return (record.get('menu_type')=='special');
	  	});
	  	return this.menus().getAt(pos);
	},
	
	getSamplingMenu: function(){
	  	var pos = this.menus().findBy(function(record,id){
	  		return (record.get('menu_type')=='sampling');
	  	});
	  	return this.menus().getAt(pos);
	},
	
	getKidsMenu: function(){
	  	var pos = this.menus().findBy(function(record,id){
	  		return (record.get('menu_type')=='kids');
	  	});
	  	return this.menus().getAt(pos);
	},
	
	getOpinateAgreement: function(){
		var pos = this.agreements().findBy(function(record,id){
  			return (record.get('legal_type')=='opinate_policy' && record.get('locale')==TC.Setting.get('language'));
  		});
  		return this.agreements().getAt(pos);
	},
	
	getShareAgreement: function(){
		var pos = this.agreements().findBy(function(record,id){
  			return (record.get('legal_type')=='share_policy' && record.get('locale')==TC.Setting.get('language'));
  		});
  		return this.agreements().getAt(pos);
	}
	
	
});
