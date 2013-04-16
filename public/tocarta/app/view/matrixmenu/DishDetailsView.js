/**
 * @class TC.view.matrixmenu.DishDetailsView
 * @extends Ext.Container
 *
 * Menu Panel ItemsView
 *
 **/

Ext.define('TC.view.matrixmenu.DishDetailsView', {
    extend : 'Ext.Container',
    requires: [ 'TC.store.Dishes' ],
    xtype : 'matrixmenu-dishdetailsview',
    
    config : {
        cls: 'tcMatrixMenuDishDetailsView',
        layout: 'vbox',
        
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
                
                cls: 'dish-tabs',
                
                items:[
                {
                    cls: 'tab-content',
                    title: 'Acerca del plato',
                    html: 'lol1'
                },
                {
                  title: $T.comments,
                  xtype: 'dish-comments-tab'
                },
                {
                    cls: 'tab-content',
                    title: 'Datos de nutrición',
                    html: 'Datos de nutrición3'
                },
                {
                  title: $T.video,
                  xtype: 'dish-video-tab'
                }]
            },
            {
                cls: 'dish-social',
                xtype: 'container',
                flex: 2,
                items: [
                {
                    xtype: 'image',
                    mode: 'image',
                    src: 'http://news.talkqueen.com/wp-content/uploads/2012/07/twitter_icon-300x300-64x64.png'
                },
                {
                    xtype: 'image',
                    mode: 'image',
                    src: 'http://blog.ono.es/wp-content/themes/oblog/images/fb_icon.png'
                },
                {
                    xtype: 'image',
                    mode: 'image',
                    src: 'http://lydiahutchinson.com/wp-content/uploads/2011/11/Google-Plus-1-icon.png'
                }]
            }]
        }],
        
    },
    
    listeners: {
        initialize: 'onInitialize'
    },
    
    onInitialize: function()
    {
        var me = this;
        
        // Data hierarchy
        this.getItems().each(function(item)
        {
            item.setData(me.getData()[0].data);
        });
    }
    

});
