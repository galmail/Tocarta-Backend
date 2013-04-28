/**
 * @class TC.view.matrixmenu.DishDetailsView
 * @extends Ext.Container
 *
 * Menu Panel ItemsView
 *
 **/

Ext.define('TC.view.matrixmenu.DishDetailsView', {
    extend : 'Ext.Panel',
    requires: [ 'TC.store.Dishes' ],
    xtype : 'matrixmenu-dishdetailsview',
    
    config : {
        cls: 'tcMatrixMenuDishDetailsView',
        layout: 'vbox',
        listeners: {
		        initialize: 'onInitialize'
		    },
        
        items:[
        {
            xtype: 'container',
            tpl: new Ext.XTemplate(
                    '<div class="dish-name"><p>{name}</p></div>',
                    '<div class="dish-description"><p>{description}</p></div>',
                    '<div class="dish-price"><p>{price}&euro;</p></div>'
            ),
            cls: 'dish-info',
        },
        {
            xtype: 'container',
            layout: 'hbox',
            cls: 'dish-extra',
            
            items: [{
                xtype: 'tabpanel',
                tabBarPosition: 'top',
                
                layout: {
                    animation: 'fade'
                },
                
                tabBar: {
                    cls: 'tcDishContainerTabBar',
                    layout: {
                        type: 'hbox',
                        pack: 'start',
                        align: 'center'
                    }
                },
                
                itemId: 'dish-tabs',
                cls: 'dish-tabs',
                
                items:[
                {
                    itemId: 'dish-about',
                    cls: 'tab-content',
                    title: 'Acerca del plato',
                    tpl: '{description}'
                },
                {
                    itemId: 'dish-comments',
                    title: $T.comments,
                    xtype: 'dish-comments-tab'
                },
                {
                    itemId: 'dish-properties',
                    cls: 'tab-content',
                    title: 'Datos de nutrición',
                    html: 'Datos nutricion'
                },
                {
                    itemId: 'dish-video',
                    title: $T.video,
                    xtype: 'dish-video-tab'
                }]
            },
            {
                cls: 'dish-social',
                xtype: 'container',
                layout: 'hbox',
                
                items: [
                {
                    xtype: 'toolbar',
                    docked: 'top',
                    title: 'Social',
                },
                {
                    xtype: 'image',
                    cls: 'share facebook',
                },
                {
                    xtype: 'image',
                    cls: 'share twitter',
                },
                {
                    xtype: 'image',
                    cls: 'share google',
                }]
            }]
        }],
        
    },
    
    onInitialize: function()
    {
        var me = this, dataStore = this.getData()[0];
        
        this.getItems().each(function(item)
        {
<<<<<<< HEAD
            item.setData(me.getData()[0].data);            
        });
        
        this.down('#tcDishCommentsDataItemsId').setStore(me.getData()[0].comments());
=======
            item.setData(dataStore.data);            
        });
        
        this.down('#dish-tabs').setHeight(this.getHeight());
        this.down('#dish-about').setData(dataStore.data);
        this.down('#tcDishCommentsDataItemsId').setStore(dataStore.comments());
>>>>>>> dev
    }
    

});
