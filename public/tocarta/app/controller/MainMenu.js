/**
 * @class TC.controller.MainMenu
 * @extends Ext.app.Controller
 * 
 * Controls the Main Menu (sidebar views + restaurant carousel views + dish views)
 */
Ext.define('TC.controller.MainMenu', {
    extend: 'Ext.app.Controller',
    requires: ['Ext.Img','Ext.util.DelayedTask'],
    config: {
    	currentMenu: null,
      currentSection: null,
      currentSubsection: null,
      currentDish: null,
      
      views : [
      	// restaurant carousel views
      	'restaurantinfo.RestaurantCarousel',
      	// sidebar views
	    	'sidebar.MenuPanel',
	      'sidebar.MenuPanelListView',
	      'sidebar.MenuPanelItemsView',
	      // dishes views
	      'dish.DishContainer',
	      'dish.DishReviewModal'
	    ],
      
      refs: {
      	// main menu
      	mainMenu: 'main-menu',
      	// restaurant carousel
      	restaurantCarousel: 'restaurant-carousel',
      	// sidebar
      	menuPanel: 'menu-panel',
      	menuPanelListView: 'menu-panel-listview',
      	menuPanelItemsView: 'menu-panel-itemsview',
      	// dishes
      	dishContainer: 'dish-container',
      	dishTabPanel: 'dish-container tabpanel',
      	dishTitle: 'dish-title-toolbar',
      	addDishButton: 'dish-photo-tab #tcAddDishButtonId',
      	dishImg: 'dish-photo-tab #tcDishImgId',
      	dishCommentsTab: 'dish-container tabpanel dish-comments-tab',
      	dishVideoTab: 'dish-container tabpanel dish-video-tab',
      	dishNutritionFactsTab: 'dish-container tabpanel dish-nutritionfacts-tab',
      	// mini dishes
      	minidishesContainer: 'minidishes-container',
      	minidishesView: 'minidishes-view'
      },
      
    	control: {
    		restaurantCarousel: { initialize: 'restaurantCarouselShow' },
	      mainMenu: { initialize: 'mainMenuShow' },
	      menuPanel: { initialize: 'menuPanelShow', push: 'menuPanelChanged' },
	      menuPanelListView: { initialize: 'sideBarInitialize', itemtap: 'showDishesOrSubsections' },
	      menuPanelItemsView: { show: 'selectFirstItemInItemsView', itemtap: 'displayDishOrMinidishes' },
	      dishContainer: { show: 'dishContainerShow' },
	      dishVideoTab: { show: 'dishVideoShow' },
	      addDishButton: { tap: 'addDish' },
	      dishCommentsTab: { show: 'dishCommentsShow' },
	      dishNutritionFactsTab: { show: 'dishNutritionFactsShow' },
	      minidishesView: { itemtap: 'addMiniDish' }
	    }
	    
    },
    
    launch: function(){
    	console.log('TC.controller.MainMenu.launch');
    	var me = this;
    	// listen for swipe left, right navigation
    	$z(document).on('swipeLeft','#tcDishImgId',function(){
    		me.nextDish();
    		return false;
    	});
    	$z(document).on('swipeRight','#tcDishImgId',function(){
    		me.previousDish();
    		return false;
    	});
    	$z(document).on('doubleTap doubleClick','#tcDishImgId',function(el){
    		me.fullscreenDish(el);
    		return false;
    	});
    	$z(document).on('tap click','.tcDishActionReview',function(el){
    		me.dish_review_modal = Ext.create('TC.view.dish.DishReviewModal',{
    			dishId: el.target.id.split('_')[1]
    		});
    		Ext.Viewport.add(me.dish_review_modal);
	    	me.dish_review_modal.show();
    		return false;
    	});
    	
    	
    },
    
    //// WARNING: this function is called from the Main Controller
    //// Treat carefully before any change to it
    reset: function(){
      this.setCurrentSection(null);
      this.setCurrentSubsection(null);
      this.setCurrentDish(null);
    },
    
    menuPanelChanged: function(menupanel){
    	console.log('TC.controller.MainMenu.menuPanelChanged');
    	var rows = menupanel.getActiveItem().getStore().getCount()/2;
    	var cls = menupanel.getActiveItem().getCls();
			if(rows>3 && cls[0]=="tcMenuPanelItemsView"){
				$j(menupanel.getActiveItem().element.dom).find('.x-scroll-indicator-dark.x-scroll-indicator.x-scroll-indicator-y').css('opacity','0.5 !important');
			}
    },
    
    selectFirstItemInItemsView: function(dv){
    	console.log('TC.controller.MainMenu.selectFirstItemInItemsView delayed 500ms');
    	var self = this;
    	var delayedTask = null;
    	delayedTask = Ext.create('Ext.util.DelayedTask', function() {
    		console.log('TC.controller.MainMenu.selectFirstItemInItemsView callback!');
    		self.displayDishOrMinidishes(dv,0);
    		dv.select(0,false);
    		delayedTask.cancel();
    		delayedTask = null;
			});
			delayedTask.delay(500);
    },
    
    restaurantCarouselShow: function(restaurantCarouselPanel){
    	console.log('TC.controller.MainMenu.restaurantCarouselShow');
    	var banners = TC.Restaurant.banners();
    	var carousel = restaurantCarouselPanel.down('#tcRestCarouselId');
    	var items = [];
      banners.each(function(banner){
        items.push({
        	xtype: 'image',
        	src: banner.get('large_photo_url')
        });
      });
      carousel.setItems(items);
      if(items.length<2){
      	carousel.setIndicator(false);
      }
      carousel.setActiveItem(0);
    },
    
    dishCommentsShow: function(commentsTab){
    	console.log('TC.controller.MainMenu.dishCommentsShow');
    	commentsTab.down('#tcDishCommentsDataItemsId').setStore(commentsTab.getRecord().comments());
    },
    
    dishNutritionFactsShow: function(nutritionfactsTab){
    	console.log('TC.controller.MainMenu.dishNutritionFactsShow');
    	// var nutrition_facts_store = Ext.create('TC.store.NutritionFacts',{
    		// storeId: "NutritionFactsStore" + nutritionfactsTab.getRecord().getId(),
    		// data: [
    			// nutritionfactsTab.getRecord().get('nutrition_fact')
    		// ]
    	// });
    	// nutritionfactsTab.down('#tcDishNutritionFactsDataItemsId').setStore(nutrition_facts_store);
    	nutritionfactsTab.down('#tcDishNutritionFactsDataItemsId').setData(nutritionfactsTab.getRecord().get('nutrition_fact'));
    },
    
    dishTabPanelInitialize: function(tabPanel){
    	console.log('TC.controller.MainMenu.dishTabPanelInitialize');
    },
    
    sideBarInitialize: function(listView){
    	console.log('TC.controller.MainMenu.sideBarInitialize');
    	var self = this;
    	if(self.getCurrentSection()==null){
    		if(self.getCurrentMenu()){
    			listView.setStore(self.getCurrentMenu().sections());
    		}
    	}
    },
    
    mainMenuShow: function(mainMenu){
    	console.log('TC.controller.MainMenu.mainMenuShow');
    	Ext.Viewport.down('#tcTopToolbarId').show();
  		Ext.Viewport.down('#tcBottomToolbarId').show();
    },
    
    menuPanelShow: function(sidebar){
    	console.log('TC.controller.MainMenu.menuPanelShow');
    	// this.setSidebar(sidebar);
    },
    
    dishContainerShow: function(dishContainer){
    	console.log('TC.controller.MainMenu.dishContainerShow');
    },
    
    dishVideoShow: function(dishVideo){
    	console.log('TC.controller.MainMenu.dishVideoShow');
    	// dishVideo.items.first().setPosterUrl(dishVideo.getRecord().get('large_photo_url'));
    	dishVideo.items.first().setPosterUrl("http://images06.interactivewebs.com/Portals/48/images/playvideo.jpg");
    	dishVideo.items.first().setUrl(dishVideo.getRecord().get('video'));
    },
    
    showDishesOrSubsections: function(dataview,position,element){
    	console.log('TC.controller.MainMenu.showDishesOrSubsections');
    	var me = this;
    	if(dataview.getItemsClass()=='sections'){
    		// we are in sections
    		me.setCurrentSection(dataview.getStore().getAt(position));
    		if(me.getCurrentSection().subsections().getCount()==0){
    			// show dishes
    			if(me.getCurrentSection().dishes().getCount()>0){
    				me.getMenuPanel().push({
		    			itemsClass: 'dishes',
							title : me.getCurrentSection().get('name'),
							xtype : 'menu-panel-itemsview',
							store : me.getCurrentSection().dishes()
						});
    			}
	    	}
	    	else {
	    		// show subsections
	    		if(me.getCurrentSection().subsections().getCount()>0){
	    			if(me.getCurrentSection().get('hasBigSubsections')){
		    			me.getMenuPanel().push({
			    			itemsClass: 'subsections',
								title : me.getCurrentSection().get('name'),
								xtype : 'menu-panel-itemsview',
								store : me.getCurrentSection().subsections()
							});
		    		}
		    		else {
		    			me.getMenuPanel().push({
			    			itemsClass: 'subsections',
								title : me.getCurrentSection().get('name'),
								xtype : 'menu-panel-listview',
								store : me.getCurrentSection().subsections()
							});
		    		}
	    		}
	    	}
    	}
    	else if(dataview.getItemsClass()=='subsections'){
    		// we are in subsections
    		me.setCurrentSubsection(dataview.getStore().getAt(position));
    		// show dishes
    		if(me.getCurrentSubsection().dishes().getCount()>0){
    			me.getMenuPanel().push({
	    			itemsClass: 'dishes',
						title : me.getCurrentSubsection().get('name'),
						xtype : 'menu-panel-itemsview',
						store : me.getCurrentSubsection().dishes()
					});
    		}
    	}
    	else if(dataview.getItemsClass()=='dishes'){
    		console.log('***** we are in dishes *****');
    	}
    },
    
    displayDishOrMinidishes: function(dataview,position,element){
    	console.log('TC.controller.MainMenu.displayDishOrMinidishes');
    	var me = this;
    	if(dataview.getItemsClass()=='dishes'){
    		// display dish
    		// getting the dish
    		this.setCurrentDish(dataview.getStore().getAt(position));
	    	var dishContainer = this.getDishContainer();
	    	
	    	// set dishTitle
	    	var dishTitle = dishContainer.down('#tcDishTitleId');
	    	dishTitle.setTitle(this.getCurrentDish().get('name'));
	    	// set dishTitleIcons
	    	var dishTitleIcons = dishContainer.down('#tcDishTitleIconsId');
	    	dishTitleIcons.setStore(this.getCurrentDish().dishtypes());
	    	// set on/off the add button
	    	var dishAddBtn = dishContainer.down('#tcAddDishButtonId');
	    	dishAddBtn.setHidden(!TC.Restaurant.data.setting.order_button);
	    	// set dishBadge
	    	var dishBigBadge = dishContainer.down('#tcDishBigBadgeId');
	    	dishBigBadge.setHidden(!this.getCurrentDish().get('badge_name'));
	    	
	    	// set dishTabs
	    	var dishTabPanel = dishContainer.items.items[1];	    	
	    	dishTabPanel.setRecord(this.getCurrentDish());
	    	
	    	// hide comments tab when there are no comments
	    	if(this.getCurrentDish().comments().getCount()==0){
    			dishTabPanel.getTabBar().items.items[1].hide();
    		}
    		else {
    			dishTabPanel.getTabBar().items.items[1].show();
    		}
	    	
	    	// hide nutrition tab when there are no nutrition facts
	    	if(this.getCurrentDish().get('nutrition_fact')){
    			dishTabPanel.getTabBar().items.items[2].show();
    		}
    		else {
    			dishTabPanel.getTabBar().items.items[2].hide();
    		}
    		
    		// hide tabs if there is only one tab
    		var _visible_tabs = 0;
    		Ext.Array.each(dishTabPanel.getTabBar().items.items,function(item){
    			if(item.isHidden()!=true) _visible_tabs++;
    		});
    		if(_visible_tabs<2){
    			dishTabPanel.getTabBar().hide();
    		}
    		else {
    			dishTabPanel.getTabBar().show();
    		}
    		
	    	
	    	// set dish record on all items
	    	Ext.Array.each(dishTabPanel.items.items,function(item){
	    		item.setRecord(me.getCurrentDish());
	    		Ext.Array.each(item.items.items,function(subitem){
	    			if(subitem.xtype!='dataview')
	    				subitem.setRecord(me.getCurrentDish());
	    		});
	    	});
	    	
	    	// set hidden tabs
	    	dishTabPanel.getTabBar().items.last().setHidden(this.getCurrentDish().get('video')==null);
	    	
	    	// set first tab as active
	    	dishTabPanel.setActiveItem(dishTabPanel.items.items[0]);
	    	// show dish container
	    	this.getMainMenu().setActiveItem(dishContainer);
	    	
	    	// fix photo height (On android height:100% doesnt work)
	    	var _h = $j('#tcDishImgId').parent().parent().parent().height();
	    	$j('#tcDishImgId').height(_h);
	    	
    	}
    	else if(dataview.getItemsClass()=='subsections'){
    		// display mini dishes
    		// getting the subsection
	    	this.setCurrentSubsection(dataview.getStore().getAt(position));
	    	var minidishesContainer = this.getMinidishesContainer();
	    	// set subsectionTitle
	    	var subsectionTitle = minidishesContainer.down('#tcDishTitleId');
	    	subsectionTitle.setTitle(this.getCurrentSubsection().get('name'));
	    	// set miniDishes store
	    	var minidishesView = this.getMinidishesView();
	    	minidishesView.setStore(this.getCurrentSubsection().dishes());
	    	// show minidishes container
	    	this.getMainMenu().setActiveItem(minidishesContainer);
    	}
    },
    
    addDish: function(){
    	console.log('TC.controller.MainMenu.addDish');
    	TC.LastOrder.addItem(this.getCurrentDish());
    	var jDishImg = $j('.tcDishPhoto .dish-photo-container .dish-image');
    	this.animateDish(jDishImg,function(){
    		TC.LastOrder.fireEvent('adding_dish');
    	});
    },
    
    previousDish: function(){
    	console.log('TC.controller.MainMenu.previousDish');
    	var dv = this.getMenuPanelItemsView();
    	var pos = dv.getStore().indexOf(this.getCurrentDish()); 
    	if(pos > 0){
    		this.displayDishOrMinidishes(dv,pos-1);
    		dv.select(pos-1,false);
    		// scroll up
    		if(pos < dv.getStore().getCount()-4 && pos%2==1 && pos > 2){
    			dv.getScrollable().getScroller().scrollBy(0,-160);
    		}
    		else if(pos <= 2){
    			dv.getScrollable().getScroller().scrollTo(0,0);
    		}
    	}
    },
    
    nextDish: function(){
    	console.log('TC.controller.MainMenu.nextDish');
    	var dv = this.getMenuPanelItemsView();
    	var pos = dv.getStore().indexOf(this.getCurrentDish()); 
    	if(pos+1 < dv.getStore().getCount()){
    		this.displayDishOrMinidishes(dv,pos+1);
    		dv.select(pos+1,false);
    		if(pos>2 && pos%2==1 && pos < dv.getStore().getCount()-3){
    			//scroll by 160...
    			dv.getScrollable().getScroller().scrollBy(0,160);
    		}
    		else if(pos >= dv.getStore().getCount()-3){
    			dv.getScrollable().getScroller().scrollToEnd();
    		}
    	}
    },
    
    fullscreenDish: function(el){
    	console.log('TC.controller.MainMenu.fullscreenDish');
    	var self = this;
    	var originalImg = el.target.src;//.replace('large','original');
    	var fullScreenPanel = null;
    	fullScreenPanel = Ext.create('Ext.Panel', {
    		fullscreen: true,
    		centered: true,
    		width: '100%',
				height: '100%',
    		modal: true,
    		layout: 'vbox',
    		scrollable: {
    			direction: 'both',
    			directionLock: false
    		},
    		items: [
    			{
    				xtype: 'toolbar',
    				docked: 'top',
    				title: self.getCurrentDish().get('name'),
						items: [
							{
								itemId: 'closeButtonId',
								xtype: 'button',
								text: $T.close,
								handler: function(){
									fullScreenPanel.destroy();
								}
							},
							{ xtype: 'spacer' }
    				]
    			},
    			{
    				html: '<img src="'+originalImg+'" width="100%" height="100%" />'
    			}
    		],
     	}).show();
    },
    
    addMiniDish: function(dataview,position,element){
    	console.log('TC.controller.MainMenu.addMiniDish');
    	if(!TC.Restaurant.data.setting.order_button){
    		return false;
    	}
    	// set current dish
    	this.setCurrentDish(dataview.getStore().getAt(position));
    	TC.LastOrder.addItem(this.getCurrentDish());
    	var jDishImg = $j('.tcMiniDishesContainer .tcMiniDishesView #minidish_'+this.getCurrentDish().getId()+' img');
    	this.animateDish(jDishImg,function(){
    		TC.LastOrder.fireEvent('adding_dish');
    	});
    },
    
    animateDish: function(jqDishImg,callback){
    	console.log('TC.controller.MainMenu.animateDish');
    	var me = this;
    	var dishImgOriginal = jqDishImg;
    	var dishImgClone = dishImgOriginal.clone();
    	dishImgClone.css({position: 'absolute',width: dishImgOriginal.width(),height: dishImgOriginal.height(),top: dishImgOriginal.offset().top,left: dishImgOriginal.offset().left, "z-index":7});
   		dishImgClone.prependTo('body');
   		// get order button position
   		var pos = $j('#tcShowOrderBtnId').offset();
			dishImgClone.animate({opacity: 0.2, top: pos.top, left: pos.left, width: 68, height: 68}, 1200, function() {
				dishImgClone.remove();
				callback();
			});
		}
		
    
});
