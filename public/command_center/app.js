/**
 * Main App
 * 
 */

Ext.Loader.setConfig({ enabled : true });
Ext.Loader.setPath('TC', 'app');

Ext.require([
	// 'TC.store.OrderItems'
	// 'TC.store.Restaurants',
	// 'TC.store.Menus',
	// 'TC.store.Sections',
	// 'TC.store.Subsections',
	// 'TC.store.Dishes',
	// 'TC.store.DishTypes',
	// 'TC.store.Comments',
	// 'TC.store.Orders',
	// 'TC.store.SurveyQuestions'
], function(){
	
	Ext.application({
		name: 'TC',
		controllers: ['Loader','Main'],
		//models     : ['ComboType','Comment','Dish'],
		//stores: ['Menus'],
		//views: ['Viewport'],
		//autoCreateViewport: true,
		
		mainLaunch: function(){
			console.log('TC.app.mainLaunch');
			// For Desktop Version
			if(Ext.os.deviceType.toLowerCase() == 'desktop' && this.launched){
				Ext.create('TC.view.Viewport');
				return;
			}
			// For Device Version
    	if(device && this.launched){
    		// Phonegap is ready
    		
    		// load application path
	    	if(window.requestFileSystem){
	    		window.requestFileSystem(LocalFileSystem.PERSISTENT, 0, function(fs){
						$tc.fullPath = fs.root.fullPath;
						// launch app
    				Ext.create('TC.view.Viewport');
					});
	    	}
    	}
	  },

		launch: function(){
			console.log('TC.app.launch');
			this.launched = true;
      this.mainLaunch();
    }
				
	});
});
