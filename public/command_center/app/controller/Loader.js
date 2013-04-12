/**
 * @class TC.controller.Loader
 * @extends Ext.app.Controller
 * 
 * The Loader Controller
 * @description It prepares the app by loading the stores and configurations
 */
Ext.define('TC.controller.Loader', {
  extend: 'Ext.app.Controller',
  requires: ['TC.store.Images','TC.model.Restaurant','TC.store.Activities'],
  config: {
  	images: null,
  	routes: {
  		'': 'appUpdate',
      'load': 'appLoad',
      'update': 'appUpdate'
    },
    views: [
    	'loading.Updater'
    ],   
    refs: {
    },
    control: {
    }
  },
  
  appLoad: function(callback){
  	console.log('TC.controller.Loader.appLoad');
  },
  
  // To force all images download: fullUpdate = "yes"
  appUpdate: function(fullUpdate){
  	console.log('TC.controller.Loader.appUpdate');
  	var me = this;
  	TC.switchView('TC.view.loading.Updater');
  	if(!TC.Restaurant){
  		TC.Restaurant = Ext.create('TC.model.Restaurant',{id: 1});
  	}
  	if(!TC.RestaurantSetting || TC.RestaurantSetting.get('key')==null){ return false; }
  	TC.model.Restaurant.setProxy({
  		type: $tc.protocol,
  		url: $tc.url('get_restaurant')+'?all='+ fullUpdate +'&key='+TC.RestaurantSetting.get('key'),
  	});
  	
  	TC.model.Restaurant.load(1, {
	    scope: this,
	    failure: function(record, operation) {
	      console.log('TC.controller.Loader.appUpdate failure');
	    },
	    success: function(record, operation) {
	    	console.log('TC.controller.Loader.appUpdate success');
	      // set the record
	      TC.Restaurant = record;
	      TC.RestaurantActivities = Ext.create('TC.store.Activities');
	      TC.Restaurant.activities().each(function(activity){
	      	TC.RestaurantActivities.add(activity);
	      });
	      
	      
	      
	      // TC.RestaurantActivities = Ext.create('TC.store.Activities',{
	      	// data: TC.Restaurant.activities()
	      	// proxy: {
		  			// type: $tc.protocol,
		  			// url: $tc.url('get_restaurant')+'?key='+TC.RestaurantSetting.get('key'),
		  			// reader: {
		  				// type: 'json',
		  				// rootProperty: 'restaurant_activities'
		  			// }
		  		// }
	      // });
	      this.redirectTo('maincontrol');
	    },
	    callback: function(record, operation) {
	      console.log('TC.controller.Loader.appUpdate callback');
	    }
		});
  	
  },
  
  ////// private methods //////
  
  _fetchImages: function(callback){
  	console.log('TC.controller.Loader._fetchImages');
  	this._downloadImages(function(ok){
  		console.log('TC.controller.Loader._fetchImages downloadedOk:'+ ok);
  		Ext.Viewport.unmask();
  		if(ok){
  			TC.ajaxRequest({
	  			url: $tc.url('confirm_downloaded_images'),
			    success: callback
	  		});
  		}
  	});
  },
  
  _setDownloadingProgress: function(n,total){
  	Ext.Viewport.setMasked({xtype: 'loadmask',message: $TO.downloading+' '+n+' '+$TO.of+' '+total+' '+$TO.images+'...'});
  },
  
  _downloadImages: function(callback){
  	var me = this;
  	console.log('TC.controller.Loader._downloadImages');
  	var downloadOK = true;
  	if(!this.getImages()){
  		this.setImages(Ext.create('TC.store.Images',{
  			proxy: {
	  			type: $tc.protocol,
	  			url: $tc.url('get_images_to_download')+'?key='+TC.Setting.get('key')
	  		}
	  	}));
  	}
  	this.getImages().removeAll();
  	console.log('TC.controller.Loader._downloadImages: getting images...');
  	this.getImages().load(function(records,operation,success){
  		var numImagesToFetch = records.length;
  		if(numImagesToFetch==0){ callback(downloadOK); }
  		console.log('TC.controller.Loader._downloadImages: preparing to fetch '+ numImagesToFetch +' images.');
  		Ext.Array.each(records,function(img){
  			img.fetch({
  				success: function(entry){
  					numImagesToFetch--;
  					me._setDownloadingProgress(records.length-numImagesToFetch,records.length);
	  				if(numImagesToFetch==0){
	  					callback(downloadOK);
	  				}
  				},
  				failure: function(error){
  					console.log("**** download error source: " + error.source);
		        console.log("**** download error target: " + error.target);
		        console.log("**** upload error code: " + error.code);
  					downloadOK = false;
  					numImagesToFetch--;
  					me._setDownloadingProgress(records.length-numImagesToFetch,records.length);
	  				if(numImagesToFetch==0){
	  					callback(downloadOK);
	  				}
  				}
  			});
  		});
  	});
  }
});
