/**
 * @class TC.view.maincontrol.ActivitiesView
 * @extends Ext.Panel
 *
 * ActivitiesView Panel
 * @description This panel display the activities view
 **/

Ext.define('TC.view.maincontrol.ActivitiesView', {
	extend: 'Ext.Panel',
	requires: ['Ext.dataview.DataView','Ext.SegmentedButton'],
	xtype: 'activities-view',
	config: {
		cls : 'tcActivitiesView',
		layout: 'vbox',
		items: [
			{
				id: 'tcActivitiesMsgToolbarId',
				xtype: 'toolbar',
				items: [
					{
						id: 'tcActivitiesTitleId',
						xtype: 'title'
						// title: $TO.new_activities_title
					},
					{ xtype: 'spacer' },
					{
						xtype: 'segmentedbutton',
						items: [
							{
								itemId: 'tcAllActivitiesBtnId',
								text: $TO.all
							},
							{
								itemId: 'tcReadActivitiesBtnId',
								text: $TO.read
							},
							{
								itemId: 'tcIncomingActivitiesBtnId',
								text: $TO.incoming,
								pressed: true
							}
						]
					}
				]
			},
			{
				flex: 1,
				// scrollable: false,
				itemId: 'tcActivitiesDataViewId',
				cls : 'tcActivitiesDataView',
				xtype: 'dataview',
				itemTpl: new Ext.XTemplate(
			    '<div id="activity_{id}" class="activity">',
			    	'<div class="table_icon">{table_number}</div>',
			    	'<div class="pico_icon"></div>',
			    	'<div class="bubble">',
			    		'<div class="info">',
				      	'<span class="activity_table">'+$TO.table+' {table_number}</span>',
				      	'<span class="activity_date"><tpl if="date != null"> '+$TO.since+' {date}</tpl></span>',
				      	'<div class="activity_description">{name:this.translate}</div>',
				      '</div>',
				    	'<div class="buttons">',
					    	'<tpl if="order!=null">',
						    	'<div id="tcViewOrderBtnId_{id}" class="tcViewOrderBtn x-button x-iconalign-center x-button-plain">',
						    		'<span style="display: none;" class="x-badge"></span>',
						    		'<span class="x-button-icon note2 x-icon-mask"></span>',
						    		'<span style="display: none;" class="x-button-label"></span>',
						    	'</div>',
					    	'</tpl>',
					    	'<tpl if="ack==null">',
						    	'<div id="tcCheckBtnId_{id}" class="tcCheckBtn x-button x-iconalign-center x-button-plain <tpl if="order!=null">x-item-disabled</tpl>">',
						    		'<span style="display: none;" class="x-badge"></span>',
						    		'<span class="x-button-icon check2 x-icon-mask"></span>',
						    		'<span style="display: none;" class="x-button-label"></span>',
						    	'</div>',
					    	'</tpl>',
				      '</div>',
			    	'</div>',
			    '</div>',
				{
					translate: function(name) {
						return $TO[name];
					}
				})
			}
		]
		
	}
});