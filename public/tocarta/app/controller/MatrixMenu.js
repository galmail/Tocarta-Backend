/* Comentario */
/**
 * @class TC.controller.MatrixMenu
 * @extends Ext.app.Controller
 * 
 * Controls the Matrix Menu
 */
Ext.define('TC.controller.MatrixMenu', {
    extend: 'Ext.app.Controller',
    requires: [],
    
    config: {
      
      routes: {
        'cmp1test' : 'cmp1test',
        'detailstest' : 'detailstest',
        'tiletest' : 'tiletest',
      },
      
      views : [
        'TC.view.matrixmenu.DishTiledView',
        'TC.view.matrixmenu.DishImageView',
        'TC.view.matrixmenu.DishTextView',
        'TC.view.matrixmenu.MiniDishImageView',
        'TC.view.matrixmenu.MiniDishTextView',
        'TC.view.matrixmenu.DishDetailsView'
	    ],
      
      refs: {
      	// matrix menu
      	matrixMenu: 'matrix-menu',
      	matrixCarousel: '#matrix-carousel'
      },
      
    	control: {
	      matrixMenu: { show: 'matrixMenuShow' }
	    }
	    
    },
    
    launch: function(){
    	console.log('TC.controller.MatrixMenu.launch');
    },
    
    matrixMenuShow: function(){
    	console.log('TC.controller.MatrixMenu.matrixMenuShow');
    
        /*
         * Prueba componentes Nv1
         */
        
        var me = this, dish_views = [];
        
        TC.Restaurant.getMainMenu().sections().getAt(0).dishes().each(function(dish)
        {
            dish_views.push(me.printDish(dish));
        });
        
        this.getMatrixMenu().setItems(
        {
            xtype: 'carousel', 
            id : 'matrix-carousel',
            direction : 'horizontal',
            indicator: false,
            directionLock : true, 
            items: dish_views
        });
    },
    
    
    detailstest: function(){
        console.log('TC.controller.MatrixMenu.detailstest');
        
         /*
         * Prueba DishDetailsView (Nv1)
         */
         this.getMatrixMenu().setItems(Ext.create('TC.view.matrixmenu.DishDetailsView', { data: [TC.Restaurant.getMainMenu().sections().getAt(0).dishes().getAt(0)]})); 
    },
       
    tiletest: function(){
        console.log('TC.controller.MatrixMenu.tiletest');
        
        /*
         * Prueba TiledView (Nv2)
         */
       this.getMatrixMenu().setItems(this.tiledView(TC.Restaurant.getMainMenu().sections().getAt(0).dishes()));
    },
     
    tiledView: function (dishes){
    	console.log('TC.controller.MatrixMenu.tiledView');
    	
    	var me = this, section_view = [], container_width = 0, container_height = 0, priority_sum = 0, priority_avg = 0;
    	
    	var container_width = this.getMatrixMenu().element.getWidth();
    	var container_height = this.getMatrixMenu().element.getHeight();

        var tile_width = ((container_width * 25) / 100);
            tile_height = ((container_height * 45) / 100);
            
        console.log("Tile width:" + tile_width + " de " + container_width);
        console.log("Tile height:" + tile_height + " de " + container_height);
        
        dishes.each(function(dish)
        {
            var dish_view = me.printDish(dish, 'TC.view.matrixmenu.MiniDishImageView');
                dish_view.setWidth(tile_width + "px");
                dish_view.setHeight(tile_height + "px");
            
            section_view.push(dish_view);
        });
        
    	return Ext.create('TC.view.matrixmenu.DishTiledView', {width: container_width, height: container_height, scrollable: 'vertical', items: section_view });
    },
    
   
    printDish: function (dish, view){
    	console.log('TC.controller.MatrixMenu.printDish');
    	
    	var dish_view = null;
    	
    	if (view != undefined)
            dish_view = Ext.create(view, { data: [dish] });
    	else if (dish.data.large_photo_url.length > 0)
    		dish_view = Ext.create('TC.view.matrixmenu.DishImageView', { data: [dish] });
	    else
	    	dish_view = Ext.create('TC.view.matrixmenu.DishTextView', { data: [dish] }); 
	    
    
        /*
       // Para PRUEBAS: Genera una vista aleatoria para el plato 
       var randomNumber = Math.floor(Math.random() * 3) % 2;
       
       switch (randomNumber)
       {
           
           case 1:
                dish_view = Ext.create('TC.view.matrixmenu.DishTextView', { data: [dish] });
           break;
           
           default: 
                dish_view = Ext.create('TC.view.matrixmenu.DishImageView', { data: [dish] });
           break;
       }
       */
    
	    return dish_view;
    },

});
