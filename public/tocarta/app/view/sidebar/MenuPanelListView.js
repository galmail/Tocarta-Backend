/**
 * @class TC.view.sidebar.MenuPanelListView
 * @extends Ext.DataView
 *
 * Menu Panel ListView
 *
 **/

Ext.define('TC.view.sidebar.MenuPanelListView', {
	extend : 'Ext.DataView',
	//requires: ['TC.store.Sections'],
	xtype : 'menu-panel-listview',
	config : {
		itemsClass: 'sections', // one of (sections,subsections,dishes)
		cls : 'tcMenuPanelListView',
		itemTpl: [
      '<div class="item" href="#">',
				'<img class="item-thumbnail" src="{mini_photo_url}">',
				'<span class="item-title">{name}</span>',
			'</div>'
		].join('')
	}

});
