/**
 * @class TC.view.matrixmenu.InfiniteMenu
 * @extends Ext.Panel
 *
 * Matrix Menu Panel
 * @description This panel displays the infinite menu
 **/

Ext.define('TC.view.matrixmenu.InfiniteMenu', {
    extend: 'Ext.Panel',
    
    xtype: 'infinite-menu',
    
    config: {
        cls: 'tcInfiniteMenu',
        
        layout: 'hbox',
        scrollable: 'horizontal',
        
        items: [
                
        ]
    }
});
