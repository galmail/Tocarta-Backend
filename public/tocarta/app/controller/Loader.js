/**
 * @class TC.controller.Loader
 * @extends Ext.app.Controller
 * 
 * The Loader Controller
 * @description It prepares the app by loading the stores and configurations
 */
Ext.define('TC.controller.Loader', {
  extend: 'Ext.app.Controller',
  requires: ['TC.store.Images','TC.model.Restaurant','TC.store.Restaurants'],
  config: {
  	images: null,
  	routes: {
      'load': 'appLoad',
      'update': 'appUpdate',
      'reset': 'appReset',
      'reload': 'appReload'
    },
    views: [
    	'loading.Loader',
    	'loading.Updater'
    ],   
    refs: {
    },
    control: {
    }
  },
  
  appLoad: function(callback){
  	console.log('TC.controller.Loader.appLoad');
  	TC.switchView('TC.view.loading.Loader');
  	if(!TC.Restaurant){
  		TC.Restaurant = Ext.create('TC.model.Restaurant',{id: 1});
  	}
  	TC.model.Restaurant.setProxy(TC.Restaurant.getLocalProxy());
  	TC.model.Restaurant.load(1, {
  		timeout: $tc.timeout,
	    scope: this,
	    failure: function(record, operation) {
	      console.log('TC.controller.Loader.appLoad failure');
	    },
	    success: function(record, operation) {
	      console.log('TC.controller.Loader.appLoad success');
	    },
	    callback: function(record, operation) {
	      if(record==null){
	      	console.log('TC.controller.Loader.appLoad redirecting to update');
	      	this.redirectTo('update');
	      }
	      else {
	      	// set record
	      	TC.Restaurant = record;
	      	console.log('TC.controller.Loader.appLoad redirecting to home');
	      	// reload all
	      	this.fireReloadEvent();
	      	// redirect to home
	      	this.redirectTo('home');
	      }
	    }
		});
  },
  
  fireReloadEvent: function(){
  	Ext.Viewport.down('top-toolbar').fireEvent('reload');
  	Ext.Viewport.down('bottom-toolbar').fireEvent('reload');
  	Ext.Viewport.down('viewport').fireEvent('reload');
  },
  
  appReload: function(done){
  	this.appUpdate(false,function(){
  		window.location.reload();
  	});
  },
  
  // To force all images download: fullUpdate = "yes"
  appUpdate: function(fullUpdate,callback){
  	var me = this;
  	console.log('TC.controller.Loader.appUpdate');
  	TC.switchView('TC.view.loading.Updater');
  	if(!TC.Restaurant){
  		TC.Restaurant = Ext.create('TC.model.Restaurant',{id: 1});
  	}
  	if(!TC.Setting.data){
  		TC.validateLicenseKey();
  		return false;
  	}
  	TC.model.Restaurant.setProxy({
  		type: $tc.protocol,
  		url: $tc.url('get_restaurant')+'?all='+ fullUpdate +'&key='+TC.Setting.get('key')+'&locale='+TC.Setting.get('language'),
  	});
  	Ext.Viewport.setMasked({xtype: 'loadmask',message: $TO.updating_menu});
  	TC.model.Restaurant.load(1, {
	    scope: this,
	    failure: function(record, operation) {
	      console.log('TC.controller.Loader.appUpdate failure');
	      Ext.Viewport.unmask();
	      // error has occurred, ask if user wish to try again (if not go to home)
	      $tc.confirmMsg($TO.update_menu_failed_question,function(btnPressed){
	  			if(btnPressed == 'yes'){
		  			me.redirectTo('update');
		     	}
		     	else {
		     		me.redirectTo('home');
		     	}
	     	});
	    },
	    success: function(record, operation) {
	      // set the record
	      TC.Restaurant = record;
	      console.log('TC.controller.Loader.appUpdate success');
	      // remove any instance of restaurant
	      var _rest = Ext.create('TC.store.Restaurants');
	      _rest.load(function(){
	      	_rest.removeAll();
	      	_rest.sync();
	      	_rest = null;
	      });
	      // and save the new one locally
	      TC.model.Restaurant.setProxy(TC.Restaurant.getLocalProxy());
	      TC.Restaurant.save(function(){
	      	if(Ext.os.is.Desktop){
	      		Ext.Viewport.unmask();
	      		console.log('TC.controller.Loader.appUpdate redirecting to load');
	      		if(!callback){
	      			me.redirectTo('load');
	      		}
	      		else {
	      			callback();
	      		}
	      	}
	      	else {
	      		console.log('TC.controller.Loader.appUpdate fetching images...');
	      		me._fetchImages(fullUpdate,function(ok){
	      			console.log('TC.controller.Loader.appUpdate redirecting to load');
	      			Ext.Viewport.unmask();
	      			if(!ok){
	      				$tc.confirmMsg($TO.update_download_failed_question,function(btnPressed){
					  			if(btnPressed == 'yes'){
						  			me.redirectTo('update');
						     	}
						     	else {
						     		if(!callback){
				      				me.redirectTo('load');
				      			}
				      			else {
				      				callback();
				      			}
						     	}
					     	});
	      			}
				      else {
				      	if(!callback){
		      				me.redirectTo('load');
		      			}
		      			else {
		      				callback();
		      			}
				      }
	      		});
	      	}
	      });
	    },
	    callback: function(record, operation) {
	      console.log('TC.controller.Loader.appUpdate callback');
	    }
		});
  },
  
  appReset: function(){
  	this.appUpdate("yes");
  },
  
  ////// private methods //////
  
  _fetchImages: function(fetchAll,callback){
  	console.log('TC.controller.Loader._fetchImages');
  	this._downloadImages(fetchAll,function(ok){
  		console.log('TC.controller.Loader._fetchImages downloadedOk:'+ ok);
  		Ext.Viewport.unmask();
  		if(ok){
  			TC.ajaxRequest({
	  			url: $tc.url('confirm_downloaded_images'),
			    // success: callback
	  		});
  		}
  		callback(ok);
  	});
  },
  
  _setDownloadingProgress: function(n,total){
  	Ext.Viewport.setMasked({xtype: 'loadmask',message: $TO.downloading+' '+n+' '+$TO.of+' '+total+' '+$TO.images+'...'});
  },
  
  _downloadImages: function(fetchAll,callback){
  	var me = this;
  	console.log('TC.controller.Loader._downloadImages');
  	var downloadOK = true;
  	if(!this.getImages()){
  		this.setImages(Ext.create('TC.store.Images',{
  			proxy: {
	  			type: $tc.protocol,
	  			url: $tc.url('get_images_to_download')+'?key='+TC.Setting.get('key')+'&all='+fetchAll
	  		}
	  	}));
  	}
  	this.getImages().removeAll();
  	console.log('TC.controller.Loader._downloadImages: getting images...');
  	this.getImages().load(function(records,operation,success){
  		var numImagesToFetch = records.length;
  		if(numImagesToFetch==0){ callback(downloadOK); }
  		console.log('TC.controller.Loader._downloadImages: preparing to fetch '+ numImagesToFetch +' images.');
  		
  		
  		
  		
  		// Ext.Array.each(records,function(img){
  			// img.fetch({
					// success: function(entry){
						// numImagesToFetch--;
						// var imgsDownloaded = records.length - numImagesToFetch;
						// me._setDownloadingProgress(imgsDownloaded,records.length);
	  				// if(numImagesToFetch==0){
	  					// callback(downloadOK);
	  				// }
					// },
					// failure: function(error){
						// // skip this img then
		     		// console.log("**** download error source: " + error.source);
		        // console.log("**** download error target: " + error.target);
		        // console.log("**** upload error code: " + error.code);
						// downloadOK = false;
						// numImagesToFetch--;
						// me._setDownloadingProgress(records.length-numImagesToFetch,records.length);
	  				// if(numImagesToFetch==0){
	  					// callback(downloadOK);
	  				// }
					// }
				// });
  		// });
  		
  		
  		
  		
  		
  		
  		
  		
  		
  		
  		var fetchImg = function(img){
  			img.fetch({
					success: function(entry){
						numImagesToFetch--;
						var imgsDownloaded = records.length - numImagesToFetch;
						me._setDownloadingProgress(imgsDownloaded,records.length);
	  				if(numImagesToFetch==0){
	  					callback(downloadOK);
	  				}
	  				else {
	  					fetchImg(records[imgsDownloaded]);
	  				}
					},
					failure: function(error){
						$tc.confirmMsg($TO.download_img_failed + img.split('/').reverse()[0] + $TO.download_img_failed_question,function(btnPressed){
			  			if(btnPressed == 'yes'){
				  			fetchImg(img);
				     	}
				     	else {
				     		// skip this img then
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
					}
				});
  		}
  		fetchImg(records[0]);
  		
  		
  		
  		
  	});
  }
});
