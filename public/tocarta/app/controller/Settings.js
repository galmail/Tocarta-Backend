/**
 * @class TC.controller.Settings
 * @extends Ext.app.Controller
 * 
 * The Settings Controller
 * @description controls the settings
 */
Ext.define('TC.controller.Settings', {
  extend: 'Ext.app.Controller',
  requires: ['Ext.ActionSheet'],
  config: {
  	routes: {
      
    },
    views: [
    	'settings.SettingsView'
    ],   
    refs: {
    	settings: 'settings-view',
    	settingsContainer: 'settings-view #tcSettingsContainerId',
    	switchTableView: 'settings-view #tcSettingsContainerId #tcSwitchTableId',
    	waiterLoginView: 'settings-view #tcSettingsContainerId #tcWaiterLoginId',
    	cancelButton: 'settings-view #cancelButtonId',
    	saveSettingsButton: 'settings-view #saveButtonId',
    	updateMenuButton: 'settings-view #tcSettingsContainerId #tcSwitchTableId #updateMenuButtonId',
    	changeLicenseButton: 'settings-view #tcSettingsContainerId #tcSwitchTableId #changeTabletIdButtonId',
    	waiterPadButton: 'waiter-login button'
    	
    },
    control: {
    	settings: { hide: 'onSettingsHide', show: 'onSettingsShow' },
    	cancelButton: { tap: 'closeSettings' },
    	saveSettingsButton: { tap: 'saveSettingsTapped' },
    	waiterPadButton: { tap: 'waiterPadButtonTapped' },
    	updateMenuButton: { tap: 'updateMenuButtonTapped' },
    	changeLicenseButton: { tap: 'changeLicenseButtonTapped' }
    }
  },
  
  launch: function(){
  	console.log('TC.controller.Settings.launch');
  },
  
  onSettingsHide: function(){
  	console.log('TC.controller.Settings.onSettingsHide');
  	$j('.tcWaiterLogin .tcWaiterCode .box').val('');
  	this.getSettingsContainer().setActiveItem(this.getWaiterLoginView());
  	this.getSaveSettingsButton().hide();
  },
  
  onSettingsShow: function(){
  	console.log('TC.controller.Settings.onSettingsShow');
  	var me = this;
  	// load form current setting
  	TC.model.Setting.load(1,{
  		success: function(record,operation){
  			record.set('new_table',false);
  			me.getSwitchTableView().setRecord(record);
  		}
  	});
  },
  
  closeSettings: function(){
  	console.log('TC.controller.Settings.closeSettings');
  	this.getSettings().hide();
  },
  
  saveSettingsTapped: function(){
  	console.log('TC.controller.Settings.saveSettings');
  	var me = this;
  	// get settings
  	var setting = this.getSwitchTableView().getRecord();
  	var lastSettingData = Ext.apply({},setting.getData());
  	setting.setData(Ext.apply(setting.getData(),this.getSwitchTableView().getValues()));
  	Ext.Viewport.setMasked({xtype: 'loadmask',message: $TO.updating_settings});
  	this._checkInTable(setting,function(){
  		Ext.Viewport.unmask();
  		setting.save();
  		TC.LastOrder.clearOrder();
			me.getSettings().hide();
			$tc.alertMsg($TO.settings_update_confirmation);
  	}, function(msg){
  		Ext.Viewport.unmask();
  		// restore settings
  		setting.setData(lastSettingData);
  		setting.save();
  		// show failure message
	  	$tc.alertMsg(msg);
	  });
  },
  
  waiterPadButtonTapped: function(btn){
  	console.log('TC.controller.Settings.waiterPadButtonTapped');
  	var box = $j('.tcWaiterLogin .tcWaiterCode .box[value=]:first');
  	box.val(btn.getText());
  	// check if this is the last box
  	if(box[0]===$j('.tcWaiterLogin .tcWaiterCode .box:last')[0]){
  		// get waiters code
  		var code = "";
  		$j('.tcWaiterLogin .tcWaiterCode .box').each(function(pos,box){ code += box.value; });
  		if(parseInt(code)==TC.Restaurant.data.setting.access_key){
  			this.getSettingsContainer().setActiveItem(this.getSwitchTableView());
  			this.getSaveSettingsButton().show();
  		}
  		else {
  			$j('.tcWaiterLogin .tcWaiterCode .box').val('');
  		}
  	}
  },
  
  updateMenuButtonTapped: function(btn){
  	console.log('TC.controller.Settings.updateMenuButtonTapped');
  	// show action sheet
  	if(!this.actions){
  		this.actions = Ext.Viewport.add({
  			xtype: 'actionsheet',
  			items: [
  				{
  					text: $TO.update_menu,
  					scope: this,
  					handler: function(){
  						this.actions.hide();
  						this.closeSettings();
  						this.redirectTo('update');
  					}
  				},
  				{
  					text: $TO.update_override_menu,
  					ui: 'decline',
  					scope: this,
  					handler: function(){
  						this.actions.hide();
  						this.closeSettings();
  						this.redirectTo('reset');
  					}
  				},
  				{
  					text: $TO.cancel,
  					scope: this,
  					handler: function(){
  						this.actions.hide();
  					}
  				}
  			]
  		});
  	}
  	this.actions.show();
  },
  
  changeLicenseButtonTapped: function(btn){
  	console.log('TC.controller.Settings.changeLicenseButton');
  	var me = this;
  	$tc.confirmMsg($TO.change_license_question,function(btn){
  		if(btn=="yes"){
  			Ext.Viewport.setMasked({xtype: 'loadmask',message: $TO.waiting_confirmation});
    		me._resetLicense(function(){
    			Ext.Viewport.unmask();
    			TC.showMsg($TO.comm_error,'error');
    		});
    	}
   	});
  },
  
  _resetLicense: function(callback){
  	console.log('TC.controller.Settings._resetLicense');
  	TC.ajaxRequest({
  		url: $tc.url('reset_license'),
	   	success: function(response){
	   		var res = Ext.decode(response.responseText);
	   		if(res.result){
	   			localStorage.clear();
	   			window.location.reload();
	   		}
	   		else{
	   			callback();
	   		}
	   	},
	   	failure: function(){
	   		callback();
	   	}
  	});
  },
  
  _checkInTable: function(setting,successCallback,failureCallback){
  	console.log('TC.controller.Settings._checkInTable');
  	TC.ajaxRequest({
  		url: $tc.url('checkin_table'),
  		params: {
        table: setting.get('table'),
        language: setting.get('language'),
        dinners: setting.get('num_dinners'),
        new_table: setting.get('new_table')
	   	},
	   	success: function(response){
	   		var res = Ext.decode(response.responseText);
	   		if(res.result){
	   			successCallback();
	   		}
	   		else{
	   			var msg = $TO.wrong_data_was_introduced;
	   			failureCallback(msg);
	   		}
	   	},
	   	failure: function(){
	   		var msg = $TO.comm_error;
	   		failureCallback(msg);
	   	}
  	});
  }
  
});
