/**
 * ComboType Class
 * 
 */

Ext.define('TC.model.ComboType', {
	extend : 'Ext.data.Model',
	config: {
		fields : [
			{ name : "id", type : "int"},
			{ name : "name", type : "string"},
			{ name : "description", type : "string"},
			{ name : "price", type : "float"}
		]
	}
});
