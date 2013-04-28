/**
 * @class TC.view.matrixmenu.MiniDishTextView
 * @extends Ext.Container
 *
 * Menu Panel ItemsView
 *
 **/

Ext.define('TC.view.matrixmenu.MiniDishTextView', {
    extend : 'Ext.Container',
    requires: [ 'TC.store.Dishes' ],
    xtype : 'matrixmenu-minidishtextview',
    
    config : {
        cls: 'tcMatrixMenuMiniDishTextView',
        layout: 'vbox',
        listeners: {
		        initialize: 'onInitialize'
		    },
        
        items:[
        {
            xtype: 'container',
            tpl: '<h1>{name}</h1>',
            cls: 'dish-name',
        },
        {
            xtype: 'container',
            tpl: new Ext.XTemplate(
                    '<div class="dish-description"><p>{description}</p></div>',
                    '<div class="dish-price"><p>{price}&euro;</p></div>'
            ),
            cls: 'dish-info'
        }],
        
    },
    
    onInitialize: function()
    {
        var me = this;
        
        /* Data hierarchy */
        this.getItems().each(function(item)
        {
            item.setData(me.getData()[0].data);
        });
    }
    
    

});
