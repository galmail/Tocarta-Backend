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
    	'dish.DishReviewModal'
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
  
  dishReviewModalShow: function(dishReviewModal){
  	console.log('TC.controller.DishReview.dishReviewModalShow');
  	var me = this;
  	if(TC.Restaurant.getOpinateAgreement())
  		dishReviewModal.down('#tcDishReviewModalLegalId').setData(TC.Restaurant.getOpinateAgreement().data);
  	// listen for rating stars
  	$z(document).on('tap click', '.tcDishReviewModal .rating .star', me.rate);
  },
  
  submitReview: function(){
  	console.log('TC.controller.DishReview.submitReview');
  	if(!$tc.checkConnection(true)) return false;
  	var rating = $j('.star.selected').length;
		if(rating==0) return false;
  	var me = this;
  	// get the name and comment of the user
		var userName = $j('.tcDishReviewModal .userInputNameField[name=name]').val();
		var dishComment = $j('.tcDishReviewModal .tcDishReviewModalOpinion').val();
  	var dish_id = this.getDishReviewModal().getDishId();
  	// destroy modal and submit comment
  	me.getDishReviewModal().destroy();
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
		var comment = Ext.create('TC.model.Comment',{
			dish_id: dish_id,
			rating: rating,
			description: dishComment,
			name: userName
		});
		comments_to_send.add(comment);
		// submit all comments now
		comments_to_send.sync();
		// say thank you for rating
		setTimeout(function(){
			Ext.Viewport.unmask();
			$tc.alertMsg('<p align="center">'+$T.dish_rating_submited+'</p>');
		},1000);
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
