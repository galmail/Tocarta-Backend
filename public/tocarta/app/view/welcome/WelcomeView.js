/**
 * @class TC.view.welcome.WelcomeView
 * @extends Ext.Panel
 *
 * WelcomeView Panel
 * @description This panel display the welcome screen
 **/

Ext.define('TC.view.welcome.WelcomeView', {
	// requires: ['TC.store.DishTypes'],
	extend: 'Ext.Panel',
	xtype: 'welcome-screen',
	
	config: {
		cls: 'tcWelcomeView',
		// fullscreen: true,
		html: [
			'this is the welcome view<br/>'
		].join('')
	}
	
	
});
