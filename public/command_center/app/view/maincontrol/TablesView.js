/**
 * @class TC.view.maincontrol.TablesView
 * @extends Ext.Panel
 *
 * TablesView Panel
 * @description This panel display the tables view
 **/

Ext.define('TC.view.maincontrol.TablesView', {
	extend: 'Ext.Panel',
	requires: ['Ext.dataview.DataView'],
	xtype: 'tables-view',
	config: {
		cls : 'tcTablesView',
		items: [
			{
				html: [
					'<div id="all_tables_option" class="all_tables selected" onclick="app.views.tablesPanel.clearSelectedTables(this);">',
		      	'<div class="table_number">M</div>',
		      	'<div class="table_info">',
		      		'<div class="table_name">Todas las Mesas</div>',
		      		'<div class="table_status"></div>',
		      	'</div>',
		      '</div>'
				].join('')
			},
			{
				xtype: 'dataview',
				itemTpl: [
	        '<div id="table_{id}" class="table">',
	        	'<div class="table_number">{number}</div>',
	        	'<div class="table_info">',
	        		'<div class="table_name">Mesa {number}</div>',
	        		'<div class="table_status">{status}</div>',
	        	'</div>',
	        '</div>'
				].join('')
			}
		]
	}
});