/**
 * @class TC.controller.DishReview
 * @extends Ext.app.Controller
 * 
 * The Dish Rate and Review Controller
 * @description controls the dish review modal
 */
Ext.define('TC.controller.DishReview', {
  extend: 'Ext.app.Controller',
  requires: [],
  config: {
  	routes: {
      
    },
    views: [
    	// 'settings.SettingsView'
    ],   
    refs: {
    	dishReviewModal: 'dish-review-modal',
    	dishReviewSubmitBtn: 'dish-review-modal #tcDishReviewModalSubmitBtnId'
    },
    control: {
    	dishReviewModal: { show: 'dishReviewModalShow' },
    	dishReviewSubmitBtn: { tap: 'submitReview' }
    }
  },
  
  launch: function(){
  	console.log('TC.controller.DishReview.launch');
  },
  
  dishReviewModalShow: function(obj){
  	console.log('TC.controller.DishReview.dishReviewModalShow');
  	var me = this;
  	// listen for rating stars
  	$z(document).on('tap click', '.tcDishReviewModal .rating .star', me.rate);
  },
  
  submitReview: function(){
  	console.log('TC.controller.DishReview.submitReview');
  	if(!$tc.checkConnection()) return false;
  	var me = this;
		Ext.Viewport.setMasked({xtype: 'loadmask',message: $T.submit_dish_rating});
		var comments_to_send = Ext.create('TC.store.Comments',{
			proxy: {
				type: $tc.protocol,
				url: $tc.url('submit_survey') + '?key=' + TC.Setting.get('key'),
				writer: {
	    		type: 'json',
	    		root: 'survey'
	    	}
			}
		});
		// get the name and comment of the user
		var userName = $j('.tcDishReviewModal .userInputNameField[name=name]').val();
		var dishComment = $j('.tcDishReviewModal .tcDishReviewModalOpinion').val();
		// get rating of the dish
		var dish_id = this.getDishReviewModal().getDishId();
		var rating = $j('.star.selected').length;
		if(rating==0){
			Ext.Viewport.unmask();
			return false;
		}
		var comment = Ext.create('TC.model.Comment',{
			dish_id: dish_id,
			rating: rating,
			description: dishComment,
			name: userName
		});
		comments_to_send.add(comment);
		
		// submit all comments now
		comments_to_send.sync();
		// say thank you and have a nice day
		setTimeout(function(){
			Ext.Viewport.unmask();
			$tc.alertMsg('<p align="center">'+$T.dish_rating_submited+'</p>',function(){
				if(me.getDishReviewModal())
					me.getDishReviewModal().destroy();
			});
		},3000);
  },
  
  rate: function(event,a,b){
  	console.log('TC.controller.DishReview.rate');
  	var star = event.target;
		var selectedClass = 'selected';
		$j(star).addClass(selectedClass);
		var prevStar = $j(star).prev();
		while(prevStar.length>0){
			prevStar.addClass(selectedClass);
			prevStar = $j(prevStar).prev();
		}
		var nextStar = $j(star).next();
		while(nextStar.length>0){
			nextStar.removeClass(selectedClass);
			nextStar = $j(nextStar).next();
		}
  }
  
  
});
