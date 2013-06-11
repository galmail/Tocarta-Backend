/**
 * Main App
 * 
 */

Ext.Loader.setConfig({ enabled : true });
Ext.Loader.setPath({
	'TC': 'app',
	'Ext.io': './lib/sencha-io/src/io'
});
//Ext.Loader.setPath('Ext.data.proxy', 'app/proxy');
//Ext.ClassManager.setAlias('Ext.data.proxy.TocartaProxy', 'proxy.tocarta');


Ext.require([
	
], function(){
	Ext.application({
		name: 'TC',
		
		io: {
      appId: "e08d39ec-447a-4789-865a-2a53a3193aa4",
      appSecret: "ahqX0rfa0bMi0Pr9"
   	},
		
		requires: ['Ext.io.Controller'],
		controllers: ['Loader','MainMenu','DailyMenu','Order','Filter','Settings','survey.BasicSurvey','survey.SliderSurvey','Main','MultiLang','MatrixMenu','DishReview'],
		//models     : ['ComboType','Comment','Dish'],
		//stores: ['Menus'],
		//views: ['Viewport'],
		//autoCreateViewport: true,
		
		mainLaunch: function(){
			console.log('TC.app.mainLaunch');
			// For Desktop Version
			if(Ext.os.deviceType.toLowerCase() == 'desktop' && this.launched){
				console.log('TC.app.mainLaunch: desktop version');
				Ext.create('TC.view.Viewport');
				return;
			}
			// For Device Version
    	if(device && this.launched){
    		console.log('Phonegap is ready');
    		// load application path
	    	if(window.requestFileSystem){
	    		window.requestFileSystem(LocalFileSystem.PERSISTENT, 0, function(fs){
						$tc.fullPath = fs.root.fullPath;
						// launch app
    				Ext.create('TC.view.Viewport');
					});
	    	}
    	}
    	console.log('TC.app.mainLaunch: done');
	  },

		launch: function(){
			console.log('TC.app.launch');
			this.launched = true;
      this.mainLaunch();
   	}
    
    
			// TODO things to test
			
			///////// Register User Activity ///////// (register login, logout, buttons tap, dishes visited, avg time on each dish, avg time on each section, sections visited, dishes ordered, socialnets usage, etc.)
			
			///////// Error Capture and Notification /////////
			
			///////// Switch Language /////////
			
			///////// Daily Menu /////////
			
			///////// Beverages Panel /////////
			
			///////// Wines Panel /////////
			
			///////// Games Panel /////////
			
			///////// About Panel /////////  info. about Tocarta and this app version
			
			///////// Slideshow Panel /////////
				
	});
});
