/**
 * @class TC.view.sidebar.MenuPanelItemsView
 * @extends Ext.DataView
 *
 * Menu Panel ItemsView
 *
 **/

Ext.define('TC.view.matrixmenu.ItemView', {
	extend : 'Ext.DataView',
	requires: [ 'TC.store.Dishes' ],
	xtype : 'matrixmenu-itemview',
	
	config : {
		cls : 'tcMatricMenuItemView',
	
		itemTpl: new Ext.XTemplate(
			'<div class="item">',
				'<tpl if="large_photo_url.length &gt; 5">',
					'<div class="item-photo" style="background-image: url({large_photo_url});">{name}</div>',
				'<tpl elseif="large_photo_url.length &gt; -1">',
						'<div class="item-title">{name}</div>',
				'</tpl>',
			'</div>',
		{
			twoDecimals: function(price) {
				return $tc.formatNumber(price);
			}
		}),
		
		html: "hola amigos"
	}

});
