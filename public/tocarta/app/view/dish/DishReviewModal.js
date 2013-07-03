/**
 * @class TC.view.dish.DishReviewModal
 * @extends Ext.Panel
 *
 * DishReviewModal Panel
 * @description This modal allow user to rate and review a dish
 **/

Ext.define('TC.view.dish.DishReviewModal', {
	extend: 'Ext.Panel',
	xtype: 'dish-review-modal',
	config: {
		cls : 'tcDishReviewModal',
		dishId: null,
		centered: true,
		modal: true,
		hideOnMaskTap: true,
		layout: {
			type: 'vbox',
			align: 'center'
		},
		items: [
			{
				cls: 'tcDishReviewModalTitle',
				html: $T.rate_review_dish
			},
			// {
				// tpl: new Ext.XTemplate(
    			// '<div class="dish-info">',
    				// '<span class="dish-title">{name}</span>',
	    			// '<img class="dish-photo" src="{thumbnail_photo_url}"/>',
	    		// '</div>'
	    	// )
			// },
			{
				html: [
				'<div class="block">',
					'<div class="left ratingTitle">'+$T.rating+'</div>',
					'<div class="right rating">',
	      		'<div class="star"></div>',
	      		'<div class="star"></div>',
	      		'<div class="star"></div>',
	      		'<div class="star"></div>',
	      		'<div class="star"></div>',
	      	'</div>',
      	'</div>'
      	].join('')
			},
			{
				cls: 'tcDishReviewModalNameContainer',
				html: [
					'<div class="block tcDishReviewModalName">',
						'<label class="left">'+$T.your_name+'</label>',
						'<input class="right userInputNameField" type="text" name="name" placeholder="'+$T.name_example+'" />',
					'</div>'
				].join('')
			},
			{
				cls: 'tcDishReviewModalDetailsContainer',
				html: [
					'<div class="block tcDishReviewModalDetails">',
						'<label class="left">'+$T.your_comment+'</label>',
						'<textarea class="right tcDishReviewModalOpinion" placeholder="'+$T.leave_your_comment_here+'" rows="4" cols="50"></textarea>',
					'</div>'
				].join('')
			},
			{
				cls: 'tcDishReviewModalButtons',
				layout: 'hbox',
				items: [
					{
						cls: 'tcDishReviewModalCancelBtn',
						xtype: 'button',
						text: $T.cancel,
						handler: function(){
							this.parent.parent.destroy();
						}
					},
					{
						itemId: 'tcDishReviewModalSubmitBtnId',
						cls: 'tcDishReviewModalSubmitBtn',
						xtype: 'button',
						ui: 'action',
						text: $T.submit
					}
				]
			}
			
		]
	}
});