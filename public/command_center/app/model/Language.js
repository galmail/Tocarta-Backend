/**
 * Language Class
 *
 */

Ext.define('TC.model.Language', {
	extend : 'Ext.data.Model',
  fields: [
    {name: "id", type: "int"},
    {name: "name", type: "string"},
    {name: "code_name", type: "string"},
    {name: "selected", type: "boolean", defaults: false}
  ]
});

