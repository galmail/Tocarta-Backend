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
		tpl : '<label id="tcMsgBoxId" class="tcMsgBox {msgType}">{msg}</label>'
	},
	
	showMessage: function(){
		$j(this.element.dom).find('#tcMsgBoxId').fadeIn(2000);
	},
	
	hideMessage: function(){
		var me = this;
		$j(this.element.dom).find('#tcMsgBoxId').fadeOut(2000, function(){
			me.setData({msg: '', msgType: ''});
		});
	}
	
});
