/**
 * @class TC.controller.Filter
 * @extends Ext.app.Controller
 * 
 * The Filter Controller
 * @description allow users to filter dishes by type: veg, spicy, light, celiac, and more.
 */
Ext.define('TC.controller.Filter', {
  extend: 'Ext.app.Controller',
  //requires: ['TC.store.Images'],
  config: {
  	
  	routes: {
      
    },
    views: [
    	'filter.FilterView'
    ],   
    refs: {
    	filterView: 'filter-view',
    	filterViewList: 'filter-view #tcFilterOptionsId'
    },
    control: {
    	filterView: { show: 'loadFilterOptions' },
    	filterViewList: { itemtap: 'filterDishes' }
    }
  },
  
  loadFilterOptions: function(filterView){
  	console.log('TC.controller.Filter.loadFilterOptions');
  	var dishTypes = TC.Restaurant.getMainMenu().dishtypes();
  	this.getFilterViewList().setStore(dishTypes);
  	this.getFilterViewList().deselectAll();
  	// setup height
  	this.getFilterViewList().setHeight(dishTypes.getCount()*44);
  },
  
  filterDishes: function(list,position){
  	console.log('TC.controller.Filter.filterDishes');
  	this.getFilterView().hide();
  	var dishType = this.getFilterViewList().getStore().getAt(position);
  	var itemsStore = TC.Restaurant.getMainMenu().getDishesByType(dishType.get('name'));
  	var mainMenuCtrl = TC.app.getController("TC.controller.MainMenu");
  	if(!mainMenuCtrl.getMenuPanel()) return false;
  	mainMenuCtrl.getMenuPanel().reset();
  	mainMenuCtrl.getMenuPanel().push({
			itemsClass: 'dishes',
			title : dishType.get('description'),
			xtype : 'menu-panel-itemsview',
			store : itemsStore
		});
  }
  
  
});
