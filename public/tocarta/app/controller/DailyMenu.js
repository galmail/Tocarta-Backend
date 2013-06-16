/**
 * @class TC.controller.DailyMenu
 * @extends Ext.app.Controller
 * 
 * Controls the Daily Menu
 */
Ext.define('TC.controller.DailyMenu', {
    extend: 'Ext.app.Controller',
    requires: ['TC.model.Combo'],
    
    config: {
      
      views : [
      	
	    ],
      
      refs: {
      	// daily menu
      	dailyMenu: 'daily-menu',
      	dailyMenuTabPanel: 'daily-menu tabpanel',
      	dailyMenuSection: 'daily-menu dailymenu-section',
      	dailyMenuSectionPage: 'daily-menu dailymenu-sectionpage',
      	dailyMenuAddBtn: 'daily-menu #tcDailyMenuAddBtnId'
      },
      
    	control: {
	      dailyMenu: { show: 'dailyMenuDelayShow' },
	      dailyMenuTabPanel: { activeitemchange: 'tabHasChanged' },
	      dailyMenuSectionPage: { itemtap: 'selectDish', selectionchange: 'selectionChanged' },
	      dailyMenuAddBtn: { tap: 'addMenu' }
	    }
	    
    },
    
    launch: function(){
    	console.log('TC.controller.DailyMenu.launch');
    },
    
    addMenu: function(){
    	console.log('TC.controller.DailyMenu.addMenu');
    	// check if all tabs are selected
    	var all_tabs_selected = true;
    	var dailyMenuTabPanel = this.getDailyMenuTabPanel();
    	Ext.Array.each(dailyMenuTabPanel.getTabBar().items.items,function(obj){
    		if(obj.getBadgeText()==null || obj.getBadgeText()==' '){
    			all_tabs_selected = false;
    		}
    	});
    	if(all_tabs_selected){
    		// add combo to order and restart menu
    		TC.LastOrder.addItem(null,this.combo);
	    	TC.LastOrder.fireEvent('adding_dish');
	    	this.dailyMenuRestart();
    	}
    	else {
    		TC.showMsg($T.daily_menu_incomplete);
    	}
    },
    
    tabHasChanged: function(tabPanel){
    	console.log('TC.controller.DailyMenu.tabHasChanged');
    },
    
    dailyMenuRestart: function(){
    	console.log('TC.controller.DailyMenu.dailyMenuRestart');
    	var me = this;
    	var dailyMenuTabPanel = this.getDailyMenuTabPanel();
    	// unselect all dishes and select first tab
    	Ext.Array.each(dailyMenuTabPanel.items.items,function(dailyMenuSection){
    		$z(dailyMenuSection.element.dom).find('.x-item-selected').removeClass('x-item-selected');
    		dailyMenuSection.setActiveItem(0);
    	});
    	Ext.Array.each(dailyMenuTabPanel.getTabBar().items.items,function(tab){
    		tab.setBadgeText(' ');
    		tab.setCls('');
    	});
    	dailyMenuTabPanel.getTabBar().setActiveTab(0);
    	// create a new combo
  		var dailyMenu = TC.Restaurant.getDailyMenu();
  		this.combo = Ext.create('TC.model.Combo',{
  			id: TC.LastOrder.order_items().getCount()+1,
  			name: dailyMenu.get('name'),
  			price: dailyMenu.get('price')
  		});
  		this.combo.dishes().setSorters([{property : 'position',direction: 'ASC'}]);
    },
    
    dailyMenuDelayShow: function(){
    	var self = this;
    	setTimeout(function(){
    		self.dailyMenuShow(self);
  		},0);
    },
    
    dailyMenuShow: function(me){
    	console.log('TC.controller.MainMenu.dailyMenuShow');
    	// var me = this;
    	Ext.Viewport.down('#tcTopToolbarId').show();
  		Ext.Viewport.down('#tcBottomToolbarId').show();
  		var dailyMenu = TC.Restaurant.getDailyMenu();
  		this.getDailyMenu().down('#tcDailyMenuTitleId').setRecord(dailyMenu);
  		// create a new combo
  		this.combo = Ext.create('TC.model.Combo',{
  			id: TC.LastOrder.order_items().getCount()+1,
  			name: dailyMenu.get('name'),
  			price: dailyMenu.get('price')
  		});
  		this.combo.dishes().setSorters([{property : 'position',direction: 'ASC'}]);
  		dailyMenu.sections().each(function(section){
  			var dishes_per_page = (section.get('dishes_per_page')>0) ? section.get('dishes_per_page') : 3;
  			var dish_counter = 0;
  			// var section_title = { xtype: 'toolbar', title: section.get('name'), docked: 'top' };
  			var section_items = [];
  			var section_page = null;
  			var dishes = Ext.create('TC.store.Dishes');
  			section.dishes().each(function(dish){
  				if(dish_counter%dishes_per_page==0){
  					section_page = Ext.create('TC.view.dailymenu.DailyMenuSectionPage',{
  						disableSelection: !TC.Restaurant.data.setting.order_button
  					});
  					section_page.setStore(Ext.create('TC.store.Dishes'));
  					section_items.push(section_page);
  				}
  				section_page.getStore().add(dish);
  				dish_counter++;
  			});
  			me.getDailyMenuTabPanel().add({
  				title: section.get('name'),
  				cls: 'tcDailyMenuSection tcDailyMenuSection'+dishes_per_page,
  				xtype: 'dailymenu-section',
  				items: section_items,
  				indicator: section_items.length > 1
  			});
  		});
  		
  		
  		// hide badges if order option is not available
  		Ext.Array.each(me.getDailyMenuTabPanel().getTabBar().items.items,function(tab){
  			tab.setBadgeText('');
  			tab.setLabelCls('nobadge-tab-label');
  		});
    },
    
    selectionChanged: function(itemSelected, selectedDishes, eOpts){
    	console.log('TC.controller.MainMenu.selectionChanged');
    },
    
    selectDish: function(dishesList,index,dishItem){
    	console.log('TC.controller.MainMenu.selectDish');
    	if(!TC.Restaurant.data.setting.order_button) return;
    	var dailyMenuTabPanel = this.getDailyMenuTabPanel();
    	var dailyMenuSection = dailyMenuTabPanel.getActiveItem();
    	var dailyMenuSectionPosition = dailyMenuTabPanel.indexOf(dailyMenuSection);
    	if(dishItem.hasCls('x-item-selected')){
    		// select this dish and mark section as selected
    		dailyMenuTabPanel.getTabBar().getActiveTab().setBadgeText(' ');
    		dailyMenuTabPanel.getTabBar().getActiveTab().setCls('');
    		var dish = this.combo.dishes().findRecord('position',dailyMenuSectionPosition);
    		if(dish){
    			this.combo.dishes().remove(dish);
    			dish.destroy();
    		}
    	}
    	else {
    		// unselect all other dishes of the section
    		var selectedItem = $z(dailyMenuSection.element.dom).find('.x-item-selected');
    		if(selectedItem.length>0){
    			selectedItem.removeClass('x-item-selected');
    			var dish = this.combo.dishes().findRecord('position',dailyMenuSectionPosition);
    			if(dish){
    				this.combo.dishes().remove(dish);
    				dish.destroy();
    			}
    		}
    		// mark section as selected
    		dailyMenuTabPanel.getTabBar().getActiveTab().setBadgeText('✔');
    		dailyMenuTabPanel.getTabBar().getActiveTab().setCls('selected');
    		var newDish = Ext.create('TC.model.Dish',dishesList.getStore().getAt(index).getData());
    		newDish.set('position',dailyMenuSectionPosition);
    		this.combo.dishes().add(newDish);
    	}
    }
    
});
