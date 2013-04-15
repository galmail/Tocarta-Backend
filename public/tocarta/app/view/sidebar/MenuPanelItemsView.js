/**
 * @class TC.view.sidebar.MenuPanelItemsView
 * @extends Ext.DataView
 *
 * Menu Panel ItemsView
 *
 **/

Ext.define('TC.view.sidebar.MenuPanelItemsView', {
	extend : 'Ext.DataView',
	requires: [ 'TC.store.Dishes' ],
	xtype : 'menu-panel-itemsview',
	config : {
		itemsClass: 'dishes',	// one of (sections,subsections,dishes)
		cls : 'tcMenuPanelItemsView',
		itemTpl: new Ext.XTemplate(
      '<div class="item">',
      	'<div class="item-border">',
					'<tpl if="badge_name.length &gt; 5">',
						'<div class="item-badge long-badge">{badge_name}</div>',
					'<tpl elseif="badge_name.length &gt; 0">',
						'<div class="item-badge">{badge_name}</div>',
					'</tpl>',
					'<img class="item-thumbnail" src="{thumbnail_photo_url}" />',
					'<div class="item-text">',
						'<div class="item-title">{short_title}</div>',
						'<div class="item-icons">',
							'<tpl for="dishtypes">',
								'<img class="item-icon" src="{small_icon_url}" />',
							'</tpl>',
						'</div>',
					'</div>',
					'<tpl if="price"><div class="item-price">€ {price:this.twoDecimals}</div></tpl>',
				'</div>',
			'</div>',
		{
			twoDecimals: function(price) {
				return $tc.formatNumber(price);
			}
		})
	}

});
