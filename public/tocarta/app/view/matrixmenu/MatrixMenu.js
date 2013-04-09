/**
 * @class TC.view.matrixmenu.MatrixMenu
 * @extends Ext.Panel
 *
 * Matrix Menu Panel
 * @description This panel displays the matrix menu
 **/

Ext.define('TC.view.matrixmenu.MatrixMenu', {
	extend: 'Ext.Panel',
	requires: ['TC.view.matrixmenu.ItemView'],
	
	xtype: 'matrix-menu',
	
	config: {
		cls: 'tcMatrixMenu',
		layout: 'vbox',
		items: [
			{
				xtype: 'matrixmenu-itemview'
			}
		]
	}
});
