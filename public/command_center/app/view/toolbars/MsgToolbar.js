/**
 * @class TC.view.toolbars.MsgToolbar
 * @extends Ext.Toolbar
 *
 * Message Toolbar
 *
 **/

Ext.define('TC.view.toolbars.MsgToolbar', {
	extend : 'Ext.Panel',
	xtype : 'msg-toolbar',
	config : {
		cls: 'tcMsgToolbar',
		tpl : '<label class="{msgType}">{msg}</label>'
	}
});
