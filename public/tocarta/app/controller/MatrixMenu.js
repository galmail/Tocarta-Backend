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
      	'TC.view.matrixmenu.ItemView'
	    ],
      
      refs: {
      	// matrix menu
      	matrixMenu: 'matrix-menu'
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
    	printDish(TC.Restaurant.getMainMenu().sections().getAt(0).dishes().getAt(0));
    },
    
    printDish: function(dish){
    	console.log('TC.controller.MatrixMenu.printDish');
    	var dish_view = Ext.create('TC.view.matrixmenu.ItemView', {
				data: dish
			});
	    this.getMatrixMenu().setItems(dish_view);
    }
    
});
