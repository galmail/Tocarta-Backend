/**
 * TabletInfo Class
 *
 */

Ext.define('TC.model.TabletInfo', {
	extend : 'Ext.data.Model',
  fields: [
    {name: "id", type: "int"},
    {name: "uuid", type: "string"},
    {name: "os_type", type: "string"}
  ]
});
