/**
 * Translation Class
 *
 */

Ext.define('TC.model.Translation', {
	extend : 'Ext.data.Model',
	config: {
		fields: [
	    {name: "id", type: "int"},
	    {name: "key", type: "string"},
	    {name: "value", type: "string"},
	    {name: "language", type: "string"}
	  ],
		proxy: {
			type: 'localstorage',
			id  : 'translation'
		}
	}
});
