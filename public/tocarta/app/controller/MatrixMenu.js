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
      
      views : [
        'TC.view.matrixmenu.DishTiledView',
        'TC.view.matrixmenu.DishImageView',
      	'TC.view.matrixmenu.DishTextView'
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
    
    	/*var me = this, dish_views = [];
    	
    	TC.Restaurant.getMainMenu().sections().getAt(0).dishes().each(function(dish)
    	{
    		dish_views.push(me.printDish(dish));
    	});
    	
    	this.getMatrixCarousel().setItems(dish_views);
        */
       this.getMatrixMenu().setItems(this.tiledView(TC.Restaurant.getMainMenu().sections().getAt(0)));
    },
    
    tiledView: function (section){
    	console.log('TC.controller.MatrixMenu.tiledView');
    	
    	var me = this, section_view = [], container_width = 0, container_height = 0, priority_sum = 0, priority_avg = 0;
    	
    	var container_width = this.getMatrixMenu().element.getWidth();
    	var container_height = this.getMatrixMenu().element.getHeight();

        var tile_width = (container_width / section.dishes().data.length);
            tile_height = (container_height / section.dishes().data.length);
        section.dishes().each(function(dish)
        {
            var dish_view = me.printDish(dish);
                dish_view.setWidth(tile_width + "px");
                dish_view.setHeight(tile_height + "px");
            
            section_view.push(dish_view);
        });
        
    	return Ext.create('TC.view.matrixmenu.DishTiledView', {width: container_width, height: container_height, items: section_view });
    },
    
   
    printDish: function (dish){
    	console.log('TC.controller.MatrixMenu.printDish');
    	
    	var dish_view = null;
    	
    	if (dish.data.large_photo_url.length > 0)
    	{
    		dish_view = Ext.create('TC.view.matrixmenu.DishImageView', {
	    				data: [dish]
	    			});
	    }
	    else
	    {
	    	dish_view = Ext.create('TC.view.matrixmenu.DishTextView', {
	    				data: [dish]
	    			}); 
	    }
	    
    
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
