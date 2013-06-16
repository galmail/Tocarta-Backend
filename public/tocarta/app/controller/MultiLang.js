/**
 * @class TC.controller.MultiLang
 * @extends Ext.app.Controller
 * 
 * The MultiLang Controller
 * @description allow users to pick their language
 */
Ext.define('TC.controller.MultiLang', {
  extend: 'Ext.app.Controller',
  //requires: ['TC.store.Images'],
  config: {
  	
  	routes: {
      'multilang': 'loadMultiLanguageView'
    },
    views: [
    	'multilang.PickLanguageView'
    ],   
    refs: {
    	multilang: 'multilang-view',
    	multilangButton: 'multilang-view button'
    },
    control: {
    	multilang: { show: 'multilangShow' },
    	multilangButton: { tap: 'switchLanguageTapped' }
    }
  },
  
  loadMultiLanguageView: function(){
  	console.log('TC.controller.MultiLang.loadMultiLanguageView');
  	TC.switchView({
  		xtype: 'multilang-view'
  	});
  },
  
  multilangShow: function(multilangView){
  	console.log('TC.controller.MultiLang.multilangShow');
  	// hide toolbars
  	Ext.Viewport.down('#tcTopToolbarId').hide();
  	Ext.Viewport.down('#tcBottomToolbarId').hide();
  	// set supported lang
  	var langs = TC.Restaurant.data.setting.supported_lang;
  	for(var i=1;i<langs.length;i++){
	  	Ext.Viewport.down('multilang-view').add({
	  		xtype: 'button',
	  		cls: 'flag ' + langs[i],
	  		id: 'tcBtn-' + langs[i]
	  	});
  	}
  	var topPadding = (window.innerHeight / 2) - 70;
  	Ext.Viewport.down('multilang-view').setPadding(topPadding + ' 0 0 0');
  	Ext.Viewport.items.first().element.setPadding(0);
  	Ext.Viewport.down('msg-toolbar').hide();
  	Ext.Viewport.down('multilang-view').element.setStyle('background','url("'+TC.Restaurant.get('i18nbg_url')+'")');
  },
  
  switchLanguageTapped: function(btn){
  	console.log('TC.controller.Main.switchLanguage');
  	var lang = btn.id.split('-')[1];
  	Ext.Viewport.items.first().element.setPadding('0 10px');
  	Ext.Viewport.down('msg-toolbar').show();
  	// set current language
  	if(TC.Setting.get('language')!=lang){
  		TC.Setting.set('language',lang);
	  	TC.Setting.save();
	  	TC.Restaurant = TC.Restaurants.findRecord('current_locale',lang);
	  	window.location.reload();
  	}
  	else {
  		this.redirectTo('mainmenu');
  	}
  }
  
});
