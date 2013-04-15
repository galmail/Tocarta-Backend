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
    }
    
});
