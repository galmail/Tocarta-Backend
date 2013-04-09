/**
 * @class TC.view.toolbars.BottomToolbar
 * @extends Ext.Toolbar
 *
 * Bottom Toolbar
 *
 **/

Ext.define('TC.view.toolbars.BottomToolbar', {
	extend : 'Ext.Toolbar',
	xtype : 'bottom-toolbar',
	config : {
		cls: 'tcBottomToolbar',
		items : [
			{ xtype: 'spacer' },
			{
				id: 'tcLogoBtnId',
				xtype: 'button',
				iconMask: true,
    		icon: 'resources/img/common/logo/minilogo.png',
    		ui: 'plain',
    		handler: function(){
    			console.log('TC.view.toolbars.BottomToolbar.tcLogoBtnId tap');
	   		 	// TC.RestaurantActivities.load();
	   		 	TC.app.getController("TC.controller.Main").redirectTo('update');
    		}
			}
		]
	}
});
