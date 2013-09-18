/**
 * @class TC.controller.Main
 * @extends Ext.app.Controller
 * 
 * The Main Controller of the App
 */
Ext.define('TC.controller.Main', {
    extend: 'Ext.app.Controller',
    requires: ['TC.store.OrderItems','TC.model.Order','TC.model.Setting'],
    config: {
      //profile: Ext.os.deviceType.toLowerCase(),  // tablet or phone
      
      routes: {
        '': 'loadApp',
        'mainmenu': 'loadMainMenu',
        'dailymenu': 'loadDailyMenu',
        'matrixmenu': 'loadMatrixMenu',
        'home': 'goToHome'
      },
      
      views: [
	      'Viewport',
	      'help.HelpView',
	      'filter.FilterView',
	      'order.OrderView',
	      'mainmenu.MainMenu',
	      'dailymenu.DailyMenu',
	      'matrixmenu.MatrixMenu',
	    ],
	    
	    refs: {
	    	viewport: 'viewport',
	    	orderView: 'order-view',
	    	helpView: 'help-view',
	    	filterView: 'filter-view',
	    	dailymenuView: 'daily-menu',
	    	topToolbar: 'top-toolbar',
	    	homeButton: 'top-toolbar #tcHomeBtnId',
	    	switchMenuButton: 'top-toolbar #tcSwitchMenuBtnId',
	    	showOrderButton: 'top-toolbar #tcShowOrderBtnId',
	    	requestBillButton: 'top-toolbar #tcRequestBillBtnId',
	    	callWaiterButton: 'top-toolbar #tcCallWaiterBtnId',
	    	gamesButton: 'top-toolbar #tcGamesBtnId',
	    	// segmented buttons
	    	segmentedButtonsBar: 'top-toolbar segmentedbutton',
	    	mainmenuButton: 'top-toolbar segmentedbutton #tcMainMenuBtnId',
	    	dailymenuButton: 'top-toolbar segmentedbutton #tcDailyMenuBtnId',
	    	beveragesButton: 'top-toolbar segmentedbutton #tcBeveragesBtnId',
	    	dessertsButton: 'top-toolbar segmentedbutton #tcDessertsBtnId',
	    	
	    	winesButton: 'top-toolbar segmentedbutton #tcWinesBtnId',
	    	specialmenuButton: 'top-toolbar segmentedbutton #tcSpecialMenuBtnId',
	    	samplingmenuButton: 'top-toolbar segmentedbutton #tcSamplingMenuBtnId',
	    	kidsmenuButton: 'top-toolbar segmentedbutton #tcKidsMenuBtnId',
	    	
	    	// bottom toolbar
	    	bottomToolbar: 'bottom-toolbar',
	    	helpButton: 'bottom-toolbar #tcHelpBtnId',
	    	loadAppButton: 'bottom-toolbar #tcLoadAppBtnId',
	    	updateAppButton: 'bottom-toolbar #tcUpdateAppBtnId',
	    	switchLanguageButton: 'bottom-toolbar #tcChangeLangBtnId',
	    	filterButton: 'bottom-toolbar #tcFilterDishesBtnId',
	    	switchTableButton: 'bottom-toolbar #tcSwitchTableBtnId',
	    	showSurveyButton: 'bottom-toolbar #tcShowSurveyBtnId'
	    },
	    
	    control: {
	    	viewport: { initialize: 'loadApp', reload: 'reloadViewport' },
	    	topToolbar: { reload: 'reloadTopToolbar' },
	      homeButton: { tap: 'goToHome' },
	      helpButton: { tap: 'showHelp' },
	      showOrderButton: { tap: 'showOrder' },
	      showSurveyButton: { tap: 'showSurvey' },
	      requestBillButton: { tap: 'requestBill' },
	      callWaiterButton: { tap: 'callWaiter' },
	      gamesButton: { tap: 'playGames' },
	      // segmented buttons
	      mainmenuButton: { tap: 'showMainMenu' },
	      dailymenuButton: { tap: 'showDailyMenu' },
	      beveragesButton: { tap: 'showBeveragesMenu' },
	      dessertsButton: { tap: 'showDessertsMenu' },
	      
	      winesButton: { tap: 'showWinesMenu' },
	      specialmenuButton: { tap: 'showSpecialMenu' },
	      samplingmenuButton: { tap: 'showSamplingMenu' },
	      kidsmenuButton: { tap: 'showKidsMenu' },

	      loadAppButton: { tap: 'loadApp' },
	      updateAppButton: { tap: 'updateApp' },
	      switchTableButton: { tap: 'switchTable' },
	      switchLanguageButton: { tap: 'switchLanguageView' },
	      switchMenuButton: { tap: 'switchMenu' },
	      filterButton: { tap: 'showFilterOptions' },
	    }
    },
    
    init: function(){
    	console.log('TC.controller.Main.init');
    	$tc.translateSTButtons();
    	var me = this;
    	// register functions
    	TC.switchView = this.switchView;
    	TC.showMsg = this.showMsg;
    	TC.ajaxRequest = this._ajaxRequest;
    	TC.validateLicenseKey = this.validateLicenseKey;
    	TC.model.Setting.load(1,{
    		scope: this,
    		failure: function(record,operation){
    			if(!TC.Setting){
    				TC.Setting = Ext.create('TC.model.Setting',{
	    				id: 			1,
	    				table: 		$tc.currentTable,
	    				language: $tc.defaultLanguage
	    			});
    			}
    			TC.Setting.save(function(){
    				me.validateLicenseKey();
    			});
    		},
    		success: function(record,operation){
    			// loaded ok
    			TC.Setting = record;
    			if(TC.Setting.get('key')==null){
    				me.validateLicenseKey();
    			}
    		},
    		callback: function(record,operation){
    			if(!TC.LastOrder){
    				TC.LastOrder = Ext.create('TC.model.Order',{
	    				id: 			1,
	    				table: 		TC.Setting.get('table'),
	    				language: TC.Setting.get('language')
	    			});
    			}
    		}
    	});
    },
    
    launch: function(){
    	console.log('TC.controller.Main.launch');
    },
    
    reloadViewport: function(){
    	console.log('TC.controller.Main.reloadViewport');
    	if(TC.Restaurant.get('bg')!=null)
    		this.getViewport().down('viewport').element.setStyle('background','url("'+TC.Restaurant.get('bg_url')+'")');
    	if(TC.Restaurant.getMainMenu() && TC.Restaurant.getMainMenu().get('stylesheet'))
    		$tc.loadStylesheet(TC.Restaurant.getMainMenu().get('stylesheet_url'));
    	if(TC.Restaurant.getDailyMenu() && TC.Restaurant.getDailyMenu().get('stylesheet'))
    		$tc.loadStylesheet(TC.Restaurant.getDailyMenu().get('stylesheet_url'));
    	if(TC.Restaurant.getBeveragesMenu() && TC.Restaurant.getBeveragesMenu().get('stylesheet'))
    		$tc.loadStylesheet(TC.Restaurant.getBeveragesMenu().get('stylesheet_url'));
    	if(TC.Restaurant.getDessertsMenu() && TC.Restaurant.getDessertsMenu().get('stylesheet'))
    		$tc.loadStylesheet(TC.Restaurant.getDessertsMenu().get('stylesheet_url'));
    },
    
    reloadTopToolbar: function(){
    	console.log('TC.controller.Main.reloadTopToolbar');
    	
    	// this.getTopToolbar().setTitle('<img id="tcTopToolbarLogoId" src="'+ TC.Restaurant.get('logo_url') +'"/>');
    	this.getTopToolbar().down('#tcLogoImgId').setHtml('<img id="tcTopToolbarLogoId" src="'+ TC.Restaurant.get('logo_url') +'"/>');
    	
    	if(TC.Restaurant.data.setting!=null){
    		// this.getTopToolbar().down('#tcSwitchMenuBtnId').setHidden(!TC.Restaurant.getDailyMenu());
    		this.getTopToolbar().down('#tcGamesBtnId').setHidden(!TC.Restaurant.data.setting.games);
    		// this.getTopToolbar().down('#tcFilterBtnId').setHidden(!TC.Restaurant.data.setting.show_filters);
    		// this.getTopToolbar().down('#tcSwitchLanguageBtnId').setHidden(TC.Restaurant.data.setting.supported_lang.length<3);
	    	this.getTopToolbar().down('#tcCallWaiterBtnId').setHidden(!TC.Restaurant.data.setting.call_waiter_button);
	    	this.getTopToolbar().down('#tcRequestBillBtnId').setHidden(!TC.Restaurant.data.setting.request_bill_button);
	    	this.getTopToolbar().down('#tcShowOrderBtnId').setHidden(!TC.Restaurant.data.setting.order_button);
	    	
	    	
	    	// segmented buttons
	    	if(TC.Restaurant.getMainMenu()){
	    		this.getTopToolbar().down('#tcMainMenuBtnId').setHidden(false);
	    		this.getTopToolbar().down('#tcMainMenuBtnId').setText(TC.Restaurant.getMainMenu().get('name'));
	    	}
	    	if(TC.Restaurant.getSpecialMenu()){
	    		this.getTopToolbar().down('#tcSpecialMenuBtnId').setHidden(false);
	    		this.getTopToolbar().down('#tcSpecialMenuBtnId').setText(TC.Restaurant.getSpecialMenu().get('name'));
	    	}
	    	if(TC.Restaurant.getSamplingMenu()){
	    		this.getTopToolbar().down('#tcSamplingMenuBtnId').setHidden(false);
	    		this.getTopToolbar().down('#tcSamplingMenuBtnId').setText(TC.Restaurant.getSamplingMenu().get('name'));
	    	}
	    	if(TC.Restaurant.getKidsMenu()){
	    		this.getTopToolbar().down('#tcKidsMenuBtnId').setHidden(false);
	    		this.getTopToolbar().down('#tcKidsMenuBtnId').setText(TC.Restaurant.getKidsMenu().get('name'));
	    	}
	    	if(TC.Restaurant.getDailyMenu()){
	    		this.getTopToolbar().down('#tcDailyMenuBtnId').setHidden(false);
	    		this.getTopToolbar().down('#tcDailyMenuBtnId').setText(TC.Restaurant.getDailyMenu().get('name'));
	    	}
	    	if(TC.Restaurant.getBeveragesMenu()){
	    		this.getTopToolbar().down('#tcBeveragesBtnId').setHidden(false);
	    		this.getTopToolbar().down('#tcBeveragesBtnId').setText(TC.Restaurant.getBeveragesMenu().get('name'));
	    	}
	    	if(TC.Restaurant.getWinesMenu()){
	    		this.getTopToolbar().down('#tcWinesBtnId').setHidden(false);
	    		this.getTopToolbar().down('#tcWinesBtnId').setText(TC.Restaurant.getWinesMenu().get('name'));
	    	}
	    	if(TC.Restaurant.getDessertsMenu()){
	    		this.getTopToolbar().down('#tcDessertsBtnId').setHidden(false);
	    		this.getTopToolbar().down('#tcDessertsBtnId').setText(TC.Restaurant.getDessertsMenu().get('name'));
	    	}
	    	
	    	// bottom toolbar
	    	this.getBottomToolbar().down('#tcFilterDishesBtnId').setHidden(!TC.Restaurant.data.setting.show_filters);
	    	this.getBottomToolbar().down('#tcChangeLangBtnId').setHidden(TC.Restaurant.data.setting.supported_lang.length<3);
	    	
	    	
	    	this.getBottomToolbar().down('#tcShowSurveyBtnId').setHidden(!(TC.Restaurant.data.setting.show_survey && !TC.Restaurant.data.setting.order_button));
	    	
    	}
    },
    
    validateLicenseKey: function(){
    	console.log('TC.controller.Main.validateLicenseKey');
    	var me = this;
  		Ext.Msg.prompt('',$TO.enter_license_key,function(btn,key){
  			if(btn=="ok" && key.length > 0){
  				Ext.Viewport.setMasked({xtype: 'loadmask',message: $TO.validating_license_key});
  				TC.Setting.validateKey(key,function(ok){
  					Ext.Viewport.unmask();
  					if(!ok){
  						me.validateLicenseKey();
  					}
  					else {
  						me.redirectTo('update');
  					}
  				});
  			}
  			else {
  				me.validateLicenseKey();
  			}
  		});
    },
    
    showMsg: function(msg,msgType){
    	console.log('TC.controller.Main.showMsg');
    	var _msg = msg || '';
    	var _msgType = msgType || 'info';
    	var msgToolbar = Ext.Viewport.down('#tcMsgToolbarId');
    	msgToolbar.setData({msg: _msg, msgType: _msgType});
    	msgToolbar.showMessage();
    	$tc.lastMsg = new Date().getTime();
    	setTimeout(function(){
    		if(new Date().getTime()-$tc.lastMsg >= $tc.time_to_display_msg)
    			msgToolbar.hideMessage();
    	},$tc.time_to_display_msg);
    },
    
    switchLanguageView: function(){
    	console.log('TC.controller.Main.switchLanguageView');
    	this.redirectTo('multilang');
    },
    
    goToHome: function(){
    	console.log('TC.controller.Main.goToHome');
    	
    	this._updateOrderBadge();								// updates the order badge when needed
    	this._check_for_incoming_messages();		// check for incoming messages
    	this._bindTranslations();
    	
    	
    	// TODO decide if home is the multilang or mainmenu
    	// if(TC.Restaurant.data.setting.supported_lang && TC.Restaurant.data.setting.supported_lang.length>2){
    		// this.redirectTo('multilang');
    	// }
    	// else {
    		this.redirectTo('mainmenu');
    	// }
    	
    },
    
    switchMenu: function(){
    	console.log('TC.controller.Main.switchMenu');
    	var xtype = Ext.Viewport.getActiveItem().getActiveItem().xtype;
    	if(xtype=="main-menu"){
    		this.redirectTo('dailymenu');
    	}
    	else {
    		this.redirectTo('mainmenu');
    	}
    },
    
    showFilterOptions: function(btn){
    	console.log('TC.controller.Main.showFilterOptions');
    	this.getFilterView().showBy(btn);
    },
    
    showHelp: function(){
    	console.log('TC.controller.Main.showHelp');
    	this.getHelpView().show();
    },
    
    showOrder: function(){
    	console.log('TC.controller.Main.showOrder');
    	this.getOrderView().showBy(this.getShowOrderButton());
    },
    
    loadApp: function(){
    	console.log('TC.controller.Main.loadApp');
    	$j('#superloader').hide();
    	if(TC.Setting.get('key')!=null){
    		this.redirectTo('load');
    	}
    	else {
    		this.validateLicenseKey();
    	}
    },
    
    updateApp: function(){
    	console.log('TC.controller.Main.updateApp');
    	this.redirectTo('update');
    },
    
    switchView: function(newView){
    	console.log('TC.controller.Main.switchView');
    	var viewport = Ext.Viewport.getActiveItem();
    	var oldItem = viewport.getActiveItem();
    	var newItem = newView;
    	if(typeof(newView)=='string'){
    		newItem = Ext.create(newView);
    	}
    	var _elems = viewport.items.keys.length;
    	viewport.add(newItem);
    	if(viewport.items.keys.length > _elems)
    		viewport.remove(oldItem);
		},
    
    
    ////////////////// show menus //////////////////
    
    showMenu: function(menu){
    	if(menu.get('theme')=='Modern'){
    		// if(window.location.hash.indexOf('dailymenu')<0){
    			// TC.app.getController("TC.controller.MainMenu").reset();
    			TC.app.getController("TC.controller.DailyMenu").setCurrentMenu(menu);
    			this.loadDailyMenu(menu);
    		// }
    	}
    	else if(menu.get('theme')=='Minimalist'){
    		// if(window.location.hash.indexOf('matrixmenu')<0){
    			TC.app.getController("TC.controller.MatrixMenu").setCurrentMenu(menu);
    			this.loadMatrixMenu(menu);
    		// }
    	}
    	else { // if(menu.get('theme')=='Classic'){
    		// if(window.location.hash.indexOf('mainmenu')<0){
    			TC.app.getController("TC.controller.MainMenu").reset();
    			TC.app.getController("TC.controller.MainMenu").setCurrentMenu(menu);
    			this.loadMainMenu(menu);
    		// }
    	}
    },
    
    showMainMenu: function() {
      console.log('TC.controller.Main.showMainMenu');
      this.showMenu(TC.Restaurant.getMainMenu());
    },
    
    showDailyMenu: function() {
      console.log('TC.controller.Main.showDailyMenu');
      this.showMenu(TC.Restaurant.getDailyMenu());
    },
    
    showBeveragesMenu: function() {
      console.log('TC.controller.Main.showBeveragesMenu');
      this.showMenu(TC.Restaurant.getBeveragesMenu());
    },
    
    showDessertsMenu: function() {
      console.log('TC.controller.Main.showDessertsMenu');
      this.showMenu(TC.Restaurant.getDessertsMenu());
    },
    
    showWinesMenu: function() {
      console.log('TC.controller.Main.showWinesMenu');
      this.showMenu(TC.Restaurant.getWinesMenu());
    },
    
    showSpecialMenu: function() {
      console.log('TC.controller.Main.showSpecialMenu');
      this.showMenu(TC.Restaurant.getSpecialMenu());
    },
    
    showSamplingMenu: function() {
      console.log('TC.controller.Main.showSamplingMenu');
      this.showMenu(TC.Restaurant.getSamplingMenu());
    },
    
    showKidsMenu: function() {
      console.log('TC.controller.Main.showKidsMenu');
      this.showMenu(TC.Restaurant.getKidsMenu());
    },
    
    ////////////////// load menus //////////////////
    
    loadMainMenu: function(menu){
    	if(TC.Restaurant){
    		$j('#superloader').hide();
    		console.log('TC.controller.Main.loadMainMenu');
    		var _m = menu;
    		if(!menu){
    			_m = TC.Restaurant.getMainMenu();
    			TC.app.getController("TC.controller.MainMenu").reset(); // reseting the entire controller menu
    			TC.app.getController("TC.controller.MainMenu").setCurrentMenu(_m);
    		}
    		$tc.logme({
	    		action: 'view_menu',
	    		data: {
	    			menu_id: _m.getId(),
	    			menu_type: 'main-menu'
	    		}
	    	});
    		this.switchView({xtype: 'main-menu'});
    	}
    	else {
    		this.loadApp();
    	}
    },
    
    loadDailyMenu: function(menu){
    	if(TC.Restaurant){
    		console.log('TC.controller.Main.loadDailyMenu');
    		var _m = menu;
    		if(!menu){
    			_m = TC.Restaurant.getMainMenu();
    		}
    		$tc.logme({
	    		action: 'view_menu',
	    		data: {
	    			menu_id: _m.getId(),
	    			menu_type: 'daily-menu'
	    		}
	    	});
    		this.switchView({xtype: 'daily-menu'});
    		this.getDailymenuView().down('#tcDailyMenuAddBtnId').setHidden(!TC.Restaurant.data.setting.order_button);
    	}
    	else {
    		this.loadApp();
    	}
    },
    
    loadMatrixMenu: function(menu){
    	if(TC.Restaurant){
    		console.log('TC.controller.Main.loadMatrixMenu');
    		var _m = menu;
    		if(!menu){
    			_m = TC.Restaurant.getMainMenu();
    		}
    		$tc.logme({
	    		action: 'view_menu',
	    		data: {
	    			menu_id: _m.getId(),
	    			menu_type: 'matrix-menu'
	    		}
	    	});
    		this.switchView({xtype: 'matrix-menu'});
    	}
    	else {
    		this.loadApp();
    	}
    },
    
    switchTable: function(){
    	console.log('TC.controller.Main.switchTable');
    	if(!this.settingsView){
    		this.settingsView = Ext.create('TC.view.settings.SettingsView');
    		Ext.Viewport.add(this.settingsView);
    	}
    	this.settingsView.show();
    },
    
    showSurvey: function(){
    	console.log('TC.controller.Main.showSurvey');
    	this.getSegmentedButtonsBar().setPressedButtons([]);
    	this.redirectTo('slidersurvey');
    },
    
    requestBill: function(){
    	console.log('TC.controller.Main.requestBill');
    	var me = this;
    	// check if this table has sent orders
    	Ext.Viewport.setMasked({xtype: 'loadmask',message: $T.loading_order});
    	TC.SentOrderItems = Ext.create('TC.store.OrderItems',{
    		proxy: {
    			type: $tc.protocol,
    			url : $tc.url('get_sent_order_items') + '?key=' + TC.Setting.get('key')
    		}
    	}).load(function(records, operation, success){
    		Ext.Viewport.unmask();
    		if(success==false){
    			TC.showMsg($T.comm_error,'error');
    			return false;
    		}
    		if(records.length==0 && TC.Restaurant.data.setting.order_button){
    			TC.showMsg($T.order_before_bill_request,'info');
    			return false;
    		}
    		else {
    			$tc.confirmMsg($T.request_bill_question,function(btn){
		    		if(btn=="yes"){
		    			Ext.Viewport.setMasked({xtype: 'loadmask',message: $T.requesting_bill});
			    		me._checkOutTable(function(ok){
			    			Ext.Viewport.unmask();
			    			if(ok){
			    				TC.showMsg($T.waiter_bring_bill,'info');
			    				if(TC.Restaurant.data.setting.show_survey)
			    					me.redirectTo('basicsurvey');
			    			}
			    			else {
			    				TC.showMsg($T.comm_error,'error');
			    			}
			    		});
		    		}
		    	});
    		}
    	});
    },
    
    callWaiter: function(callback){
    	console.log('TC.controller.Main.callWaiter');
    	$tc.confirmMsg($T.call_waiter_question,function(btn){
		  	if(btn=="yes"){
		  		Ext.Viewport.setMasked({xtype: 'loadmask',message: $T.call_waiter_loading});
		  		TC.ajaxRequest({
		    		url: $tc.url('call_waiter'),
		    		success: function(response){
		    			var res = Ext.decode(response.responseText);
		    			Ext.Viewport.unmask();
				    	if($j.isFunction(callback)){
				    		callback(res.result);
				    	}
				    	else {
				    		if(res.result){
				    			TC.showMsg($T.call_waiter_received,'success');
				    		}
				    		else {
				    			TC.showMsg($T.comm_error,'error');
				    		}
				    	}
				    },
				    failure: function(response){
				    	Ext.Viewport.unmask();
				    	if($j.isFunction(callback)){
				    		callback(false);
				    	}
				    	else {
				    		TC.showMsg($T.comm_error,'error');
				    	}
				    }
		    	});
		  	}
		  });
    },
    
    playGames: function(){
    	console.log('TC.controller.Main.playGames');
    },
    
    _checkOutTable: function(callback){
    	console.log('TC.controller.Main._checkOutTable');
	  	TC.ajaxRequest({
	  		url: $tc.url('request_bill'),
	  		success: function(response){
	  			var res = Ext.decode(response.responseText);
		    	if(res.result){
		    		// do checkout in background
		    		TC.ajaxRequest({url: $tc.url('checkout_table')});
		    	}
		    	callback(res.result);
		    },
		    failure: function(response) {
		    	callback(false);
		    }
	  	});
	  },
	  
	  _ajaxRequest: function(options){
	  	console.log('TC.controller.Main._ajaxRequest');
	  	var _params = Ext.apply({
	  		key: TC.Setting.get('key')
	  	},options.params);
	  	
	  	if(!$tc.checkConnection()) return false;
	  	
	  	Ext.Ajax.request({
		    url: options.url,
		    method: 'GET',
		    params: _params,
		    success: function(response){
		    	if(response.status != 200){
		    		if(options.failure)
		    			options.failure(response);
		    	}
		    	else {
		    		if(options.success)
		    			options.success(response);
		    	}
		    },
		    failure: options.failure,
		    callback: options.callback,
		    timeout: $tc.timeout
			});
	  },
	  
	  _bindTranslations: function(){
	  	// var changeLang = function(event,lang){
	  		// var key = event.target.className.match(/t--[a-zA-Z0-9-]+/)[0].replace('t--','');
	  		// console.log(key);
	  		// console.log(event.target.innerHTML);
	  		// var locale = lang;
	  		// // TODO get value of key for that language
	  		// var value = key + '==' + locale;
	  		// event.target.innerHTML = value;
	  	// }
	  	
	  	
	  	// lets bind stuff
	  	// $(document).on('changeLanguage', '.i18n', function(event,lang){
	  		// console.log('language has changed...');
	  		// changeLang(event,lang);
	  	// });
// 	  	
	  	// $(document).on('load', '.i18n', function(event,lang){
	  		// console.log('i18n has loaded...');
	  		// changeLang(event,lang);
	  	// });
	  	
	  },
	  
    _updateOrderBadge: function(){
			console.log('TC.controller.MainMenu._updateOrderBadge');
			var me = this;
			TC.LastOrder.setListeners({
				adding_dish: function(){
					console.log('adding_dish received, updating badge.');
					var orderBtn = me.getTopToolbar().down('#tcShowOrderBtnId');
					if(orderBtn.getBadgeText()==null){
						orderBtn.setBadgeText("1");
						me.showOrder();
					}
					else {
						orderBtn.setBadgeText(parseInt(orderBtn.getBadgeText())+1);
					}
					me._fixBadgePosition(orderBtn);
				},
				removing_dish: function(){
					console.log('removing_dish received, updating badge.');
					var orderBtn = me.getTopToolbar().down('#tcShowOrderBtnId');
					var newBadge = parseInt(orderBtn.getBadgeText())-1;
					if(newBadge < 1){
						orderBtn.setBadgeText(null);
					}
					else {
						orderBtn.setBadgeText(newBadge);
						me._fixBadgePosition(orderBtn);
					}
				},
				clearing_order: function(){
					console.log('clearing_order received, updating badge.');
					var orderBtn = me.getTopToolbar().down('#tcShowOrderBtnId');
					orderBtn.setBadgeText(null);
				}
			});
		},
		
		_fixBadgePosition: function(orderBtn){
			console.log('TC.controller.MainMenu._fixBadgePosition');
			if(orderBtn.getBadgeText().toString().length > 1){
				$j(orderBtn.element.dom).find('.x-badge:first').css({right: '15px'});
			}
			else {
				$j(orderBtn.element.dom).find('.x-badge:first').css({right: '21px'});
			}
		},
		
		
		_check_for_incoming_messages: function(){
    	console.log('TC.controller.Main._check_for_incoming_messages');
    	var me = this;
    	
			// Enable pusher logging - don't include this in production
	    // Pusher.log = function(message) {
	      // if (window.console && window.console.log) window.console.log(message);
	    // };
	    // Flash fallback logging - don't include this in production
	    // WEB_SOCKET_DEBUG = true;
	    // start listening for incoming activities
	    
	    
	    /*
	    var pusher = new Pusher($tc.pusherKey);
	    var channel = pusher.subscribe('tocarta_lk_'+TC.Setting.get('key')+'_channel');
	    channel.bind('alive', function(data) {
	    	console.log('TC.controller.Main._check_for_incoming_messages received alive message');
	    	TC.ajaxRequest({
	  			url: $tc.url('im_alive')
	  		});
	    });
	    channel.bind('update', function(data) {
	    	console.log('TC.controller.Main._check_for_incoming_messages received update message');
	    	me.redirectTo('update');
	    });
	    */
	    
	    /* Listen to NodeJS Socket.io events */
	   	var endpoint = $tc.nodeserver;
	   	var pipe = 'tocarta_lk_'+TC.Setting.get('key')+'_channel';
			console.log("Connecting to "+endpoint);
		  TC.socket = io.connect(endpoint);
		  TC.socket_channel = pipe;
		  console.log("Listening on "+pipe);
		  TC.socket.on(pipe, function (data) {
		  	if(data && data.action){
		  		console.log('TC.controller.Main._check_for_incoming_messages action: '+data.action);
		    	if(data.action=="alive"){
		    		TC.ajaxRequest({
			  			url: $tc.url('im_alive')
			  		});
		    	}
		    	else if(data.action=="update"){
		    		me.redirectTo('update');
		    	}
		  	}
		  });
    }
});
