/**
 * @class TC.controller.Main
 * @extends Ext.app.Controller
 * 
 * The Main Controller of the App
 */
Ext.define('TC.controller.Main', {
    extend: 'Ext.app.Controller',
    requires: ['TC.model.RestaurantSetting','TC.view.order.OrderView','TC.store.OrderItems'],
    config: {
      //profile: Ext.os.deviceType.toLowerCase(),  // tablet or phone
      
      ackFilter: null,
      tableFilter: null,
      activitiesTitle: null,
      
      routes: {
        'maincontrol': 'loadMainControl'
      },
      
      views: [
	      'Viewport',
	      'maincontrol.MainContainer'
	    ],
	    
	    refs: {
	    	viewport: 'viewport',
	    	topToolbar: 'top-toolbar',
	    	bottomToolbar: 'bottom-toolbar',
	    	mainContainer: 'main-container',
	    	newActivitiesFilter: 'activities-view segmentedbutton #tcIncomingActivitiesBtnId',
	    	oldActivitiesFilter: 'activities-view segmentedbutton #tcReadActivitiesBtnId',
	    	allActivitiesFilter: 'activities-view segmentedbutton #tcAllActivitiesBtnId'
	    },
	    
	    control: {
	    	// viewport: { initialize: 'loadMainControl'},
	    	mainContainer: { show: 'loadActivities' },
	    	newActivitiesFilter: { tap: 'filterNewActivities' },
	    	oldActivitiesFilter: { tap: 'filterOldActivities' },
	    	allActivitiesFilter: { tap: 'filterAllActivities' }
	    }
    },
    
    init: function(){
    	console.log('TC.controller.Main.init');
    	var me = this;
    	TC.showMsg = this._showMsg;
    	TC.ajaxRequest = this._ajaxRequest;
    	TC.switchView = this._switchView;
    	TC.model.RestaurantSetting.load(1,{
    		scope: this,
    		failure: function(record,operation){
    			console.log('TC.controller.Main.init failure');
    			TC.RestaurantSetting = Ext.create('TC.model.RestaurantSetting',{
    				id: 			1,
    				language: $tc.currentLanguage
    			});
    			TC.RestaurantSetting.save(function(){
    				me._validateLicenseKey();
    			});
    		},
    		success: function(record,operation){
    			console.log('TC.controller.Main.init success');
    			// loaded ok
    			TC.RestaurantSetting = record;
    			if(TC.RestaurantSetting.get('key')==null){
    				me._validateLicenseKey();
    			}
    		}
    	});
    },
    
    launch: function(){
    	console.log('TC.controller.Main.launch');
    },
    
    updateAllMenus: function(){
    	console.log('TC.controller.Main.updateAllMenus');
    	$tc.confirmMsg($TO.update_menus_question,function(btn){
    		if(btn=="yes"){
    			Ext.Viewport.setMasked({xtype: 'loadmask',message: $TO.update_menus_loading});
	    		TC.ajaxRequest({
		  			url: $tc.url('update_all_menus'),
				    success: function(response){
				    	Ext.Viewport.unmask();
				    	var res = Ext.decode(response.responseText);
				    	if(res.result){
				    		$tc.alertMsg($TO.updating_all_menus_now);
				    	}
				    	else {
				    		$tc.alertMsg($TO.comm_error);
				    	}
				    },
				    failure: function(){
				    	Ext.Viewport.unmask();
				    	$tc.alertMsg($TO.comm_error);
				    }
		  		});
    		}
    	});
    },
    
    filterNewActivities: function(){
    	console.log('TC.controller.Main.filterNewActivities');
    	TC.RestaurantActivities.sort('id', 'ASC');
    	TC.RestaurantActivities.clearFilter();
    	TC.RestaurantActivities.filter({
    		id: 'ack_filter',
    		filterFn: function(activity) { return activity.get("ack") == null; }
    	});
    	this.getActivitiesTitle().setTitle($TO.new_activities_title);
    },
    
    filterOldActivities: function(){
    	console.log('TC.controller.Main.filterOldActivities');
    	TC.RestaurantActivities.sort('id', 'DESC');
    	TC.RestaurantActivities.clearFilter();
    	TC.RestaurantActivities.filter({
    		id: 'ack_filter',
    		filterFn: function(activity) { return activity.get("ack") != null; }
    	});
    	this.getActivitiesTitle().setTitle($TO.read_activities_title);
    },
    
    filterAllActivities: function(){
    	console.log('TC.controller.Main.filterAllActivities');
    	TC.RestaurantActivities.sort('id', 'DESC');
    	TC.RestaurantActivities.clearFilter();
    	TC.RestaurantActivities.filter({
    		id: 'ack_filter',
    		filterFn: function(activity) { return true; }
    	});
    	this.getActivitiesTitle().setTitle($TO.all_activities_title);
    },
    
    loadActivities: function(mainContainer){
    	console.log('TC.controller.Main.loadActivities');
    	var me = this;
    	// update toolbar logo
    	this.getTopToolbar().setTitle('<img id="tcTopToolbarLogoId" src="'+ TC.Restaurant.get('logo') +'"/>');
    	$z(document).on($tc.click, '.tcTopToolbar #tcTopToolbarLogoId', me.updateAllMenus);
    	// set activities title to new activities
    	this.setActivitiesTitle(mainContainer.down('#tcActivitiesTitleId'));
    	this.getActivitiesTitle().setTitle($TO.new_activities_title);
    	// filter and sort the store for the incoming activities
    	TC.RestaurantActivities.filter({
    		id: 'ack_filter',
    		filterFn: function(activity) { return activity.get("ack") == null; }
    	});
    	TC.RestaurantActivities.sort('id', 'ASC');
    	mainContainer.down('#tcActivitiesDataViewId').setStore(TC.RestaurantActivities);
    	this._check_for_incoming_activities();
    	// bind user actions
    	$z('.tcActivitiesDataView .activity .buttons .x-button').live($tc.click,function(event){
    		var el = event.currentTarget;
    		var activityId = el.id.split('_')[1];
    		if($j(el).hasClass('tcCheckBtn') && !$j(el).hasClass('x-item-disabled')){
    			me._ackActivity(el,activityId);
    		}
    		else if($j(el).hasClass('tcViewOrderBtn')){
    			me._viewOrderOfActivity(el,activityId);
					$j(el.parentElement.children[1]).removeClass('x-item-disabled');
    		}
    		return false;
    	});
    },
    
    loadMainControl: function(){
    	if(TC.Restaurant){
    		console.log('TC.controller.Main.loadMainControl');
    		this._switchView({xtype: 'main-container'});
    	}
    	else {
    		this.redirectTo('update');
    	}
    },
    
    //// private functions ////
    
    _ackActivity: function(element, activityId){
    	console.log('TC.controller.Main._ackActivity');
    	// element.disabled = true;
    	TC.RestaurantActivities.findRecord('id',activityId).ack(function(ok,record){
    		if(!ok){
    			// element.disabled = false;
    			$tc.alertMsg($TO.comm_error);
    		}
    		else {
    			console.log('ok message');
    			// hide and set ack
    			$j(element).parents('.activity').slideUp(500,function(){
    				record.set("ack",true);
    			});
    		}
    	});
    },
    
    _viewOrderOfActivity: function(element, activityId){
    	console.log('TC.controller.Main._viewOrderOfActivity');
    	var me = this;
    	var activity = TC.RestaurantActivities.findRecord('id',activityId);
    	this.orderItems = Ext.create('TC.store.OrderItems');
    	if(!this.orderView){
    		this.orderView = Ext.create('TC.view.order.OrderView');
    		Ext.Viewport.add(this.orderView);
    	}
    	// set toolbar title
    	this.orderView.down('#tcOrderToolbarId').setTitle($TO.table_order+' ' + activity.get("table_number"));
    	// set data
    	activity.getOrder().order_items().each(function(order_item){
    		order_item.setupCombo();
    		me.orderItems.add(order_item);
    	});
    	this.orderView.down('#tcOrderDataViewId').setStore(this.orderItems);
    	this.orderView.show();
    },
    
    _check_for_incoming_activities: function(){
    	console.log('TC.controller.Main._check_for_incoming_activities');
			// Enable pusher logging - don't include this in production
	    // Pusher.log = function(message) {
	      // if (window.console && window.console.log) window.console.log(message);
	    // };
	    // Flash fallback logging - don't include this in production
	    // WEB_SOCKET_DEBUG = true;
	    // start listening for incoming activities
	    
	    /*
	    var pusher = new Pusher($tc.pusherKey);
	    var channel = pusher.subscribe('tocarta_restaurant_'+TC.Restaurant.getId()+'_channel');
	    channel.bind('activity', function(activity) {
	    	console.log('TC.controller.Main._check_for_incoming_activities received new activity!');
	    	// reload activities
	    	// TC.RestaurantActivities.load();
	    	// add new activity
	    	TC.RestaurantActivities.add(activity);
	    });
	    */
	    
	    /* Listen to NodeJS Socket.io events */
	   	var endpoint = "http://tocarta-node.herokuapp.com";
	   	var pipe = 'tocarta_restaurant_'+TC.Restaurant.getId()+'_channel';
			console.log("Connecting to "+endpoint);
		  var socket = io.connect(endpoint);
		  console.log("Listening on "+pipe);
		  socket.on(pipe, function (data) {
		  	if(data && data.action){
		  		console.log('TC.controller.Main._check_for_incoming_activities action: '+data.action);
		    	if(data.action=="activity"){
		    		TC.RestaurantActivities.add(activity);
		    	}
		  	}
		  });

    },
    
    _validateLicenseKey: function(){
    	var me = this;
  		Ext.Msg.prompt('',$TO.enter_license_key,function(btn,key){
  			if(btn=="ok" && key.length > 0){
  				Ext.Viewport.setMasked({xtype: 'loadmask',message: $TO.validating_license_key});
  				TC.RestaurantSetting.validateKey(key,function(ok){
  					Ext.Viewport.unmask();
  					if(!ok){
  						me._validateLicenseKey();
  					}
  					else {
  						me.redirectTo('update');
  					}
  				});
  			}
  			else {
  				me._validateLicenseKey();
  			}
  		});
    },
    
    _showMsg: function(msg,msgType){
    	var _msg = msg || '';
    	var _msgType = msgType || 'info';
    	var html = '<label class="'+ _msgType +'">'+ _msg +'</label>';
    	// show it
    	var msgToolbar = Ext.Viewport.down('#tcActivitiesMsgToolbarId');
    	msgToolbar.setTitle(msg);
    	
    	// $tc.lastMsg = new Date().getTime();
    	// setTimeout(function(){
    		// if(new Date().getTime()-$tc.lastMsg >= $tc.time_to_display_msg)
    			// msgToolbar.setData({msg: '', msgType: ''});
    	// },$tc.time_to_display_msg);
    },
    
    _switchView: function(newView){
    	// TODO if actual view is not in cachedViews delete it
    	// TODO if the newView is in cachedViews then show it, otherwise create it and show it
    	var viewport = Ext.Viewport.getActiveItem();
    	var oldItem = viewport.getActiveItem();
    	var newItem = newView;
    	if(typeof(newView)=='string'){
    		newItem = Ext.create(newView);
    	}
    	viewport.add(newItem);
    	viewport.setActiveItem(newItem);
    	viewport.remove(oldItem);
		},
	  
	  _ajaxRequest: function(options){
	  	var _params = Ext.apply({
	  		key: TC.RestaurantSetting.get('key')
	  	},options.params);
	  	
	  	Ext.Ajax.request({
		    url: options.url,
		    method: 'GET',
		    params: _params,
		    success: options.success,
		    failure: options.failure,
		    callback: options.callback
			});
	  }
    
});
