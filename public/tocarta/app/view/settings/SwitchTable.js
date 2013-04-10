/**
 * @class TC.view.settings.SwitchTable
 * @extends Ext.form.Panel
 *
 * SwitchTable Panel
 * @description This panel allow to switch table, set current language and also update manually, .
 **/

Ext.define('TC.view.settings.SwitchTable', {
	extend: 'Ext.form.Panel',
	requires: ['Ext.field.Select','Ext.form.FieldSet'],
	xtype: 'switch-table',
	config: {
		cls: 'tcSwitchTable',
		items: [
			{
				xtype: 'fieldset',
				title: $TO.basic_settings,
				instructions: $TO.table_info,
				defaults: {
					labelWidth: '70%'
				},
				items: [
					{
						name: 'table',
		        xtype: 'selectfield',
		        label: $TO.table,
		        options: [
	            {text: '1', value: '1'},
	            {text: '2', value: '2'},
	            {text: '3', value: '3'},
	            {text: '4', value: '4'},
	            {text: '5', value: '5'},
	            {text: '6', value: '6'},
	            {text: '7', value: '7'},
	            {text: '8', value: '8'},
	            {text: '9', value: '9'},
	            {text: '10', value: '10'},
	            {text: '11', value: '11'},
	            {text: '12', value: '12'},
	            {text: '13', value: '13'},
	            {text: '14', value: '14'},
	            {text: '15', value: '15'},
	            {text: '16', value: '16'},
	            {text: '17', value: '17'},
	            {text: '18', value: '18'},
	            {text: '19', value: '19'},
	            {text: '20', value: '20'},
	            {text: '21', value: '21'},
	            {text: '22', value: '22'},
	            {text: '23', value: '23'},
	            {text: '24', value: '24'},
	            {text: '25', value: '25'},
	            {text: '26', value: '26'},
	            {text: '27', value: '27'},
	            {text: '28', value: '28'},
	            {text: '29', value: '29'},
	            {text: '30', value: '30'}
		        ]
		     	},
		     	{
            xtype: 'checkboxfield',
            name : 'new_table',
            label: $TO.open_new_table,
            checked: false
        	},
        	{
						name: 'num_dinners',
		        xtype: 'selectfield',
		        label: $TO.no_persons,
		        options: [
	            {text: '1', value: '1'},
	            {text: '2', value: '2'},
	            {text: '3', value: '3'},
	            {text: '4', value: '4'},
	            {text: '5', value: '5'},
	            {text: '6', value: '6'},
	            {text: '7', value: '7'},
	            {text: '8', value: '8'},
	            {text: '9', value: '9'},
	            {text: '10', value: '10'}
        		]
        	}
				]
			},
			{
				xtype: 'fieldset',
				title: $TO.advanced_settings,
				instructions: $TO.warning_info,
				items: [
					{
						xtype: 'button',
						itemId: 'updateMenuButtonId',
						text: $TO.update_menu
			     },
			     {
						xtype: 'button',
						itemId: 'changeTabletIdButtonId',
						text: $TO.delete_license_key
			     }
				]
			}
		]
	}
});
