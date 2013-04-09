/**
 * Table Class
 *
 */

Ext.define('TC.model.Table', {
	extend : 'Ext.data.Model',
	config: {
		fields: [
	    {name: "id", type: "int"},
	    {name: "number", type: "int"},
	    {name: "status", type: "string"}
	  ]
	}
});
