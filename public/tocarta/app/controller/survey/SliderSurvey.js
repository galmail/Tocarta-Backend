/**
 * @class TC.controller.survey.SliderSurvey
 * @extends Ext.app.Controller
 * 
 * The Slider Survey Controller
 * @description controls the slider survey, it display carousel with one question at a time.
 */
Ext.define('TC.controller.survey.SliderSurvey', {
  extend: 'Ext.app.Controller',
  requires: ['TC.store.SurveyQuestions'],
  config: {
  	routes: {
      'slidersurvey': 'loadSurvey'
    },
    views: [
    	'survey.slider.SurveyContainer',
    	'survey.slider.SurveyPage',
    	'survey.basic.SurveyQuestions',
    	'survey.slider.SurveyOpinion'
    ],   
    refs: {
    	survey: 'survey-slider-container',
    	submitBtn: 'survey-opinion #tcSurveyOpinionSubmitBtnId'
    },
    control: {
    	survey: { show: 'showSurvey' },
    	submitBtn: { tap: 'submitSurvey' }
    }
  },
  
  launch: function(){
  	console.log('TC.controller.survey.SliderSurvey.launch');
  },
  
  submitSurvey: function(){
  	console.log('TC.controller.survey.SliderSurvey.submitSurvey');
  	if(!$tc.checkConnection()) return false;
  	var me = this;
		$tc.confirmMsg($T.send_survey_question,function(btn){
			if(btn=="yes"){
				Ext.Viewport.setMasked({xtype: 'loadmask',message: $T.send_survey_loading});
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
				
				// get the name email and comment of the user
				var userName = $j('.tcSurveyOpinion .userInputNameField[name=name]').val();
				var userEmail = $j('.tcSurveyOpinion .userInputNameField[name=email]').val();
				
				// get rating of all survey questions
				$j('.tcSurveySliderContainer .survey_question').each(function(){
					var question_id = this.id.split("survey_question_")[1];
					var rating = $j(this).find('.star.selected').length;
					if(rating>0){
						var comment = Ext.create('TC.model.Comment',{
							survey_question_id: question_id,
							rating: rating,
							name: userName,
							email: userEmail
						});
						comments_to_send.add(comment);
					}
				});
				
				
				
				// get rating and comments of all dishes
				// $j('.tcSurveyContainer .dish_eaten').each(function(){
					// var dish_id = this.id.split("dish_eaten_")[1];
					// var rating = $j(this).find('.star.selected').length;
					// var dish_comment = $j(this).find('.survey_dish_comment').val();
					// if(rating>0){
						// var comment = Ext.create('TC.model.Comment',{
							// dish_id: dish_id,
							// rating: rating,
							// description: dish_comment,
							// name: userName
						// });
						// comments_to_send.add(comment);
					// }
				// });
				
				// get restaurant's experience
				var restaurant_comment = $j('.tcSurveyOpinion .tcSurveyGeneralOpinion').val();
				if(restaurant_comment.length > 0){
					var comment = Ext.create('TC.model.Comment',{
						name: userName,
						email: userEmail,
						description: restaurant_comment
					});
					comments_to_send.add(comment);
				}
				
				// submit all comments now
				comments_to_send.sync();
				// say thank you and have a nice day
				setTimeout(function(){
					Ext.Viewport.unmask();
					$tc.alertMsg('<p align="center">'+$T.thanks_for_helping_us_improve+'</p>',function(){
						me.redirectTo('mainmenu');
					});
				},3000);
			}
		});
  },
  
  setupSurvey: function(survey){
  	console.log('TC.controller.SliderSurvey.setupSurvey');
  	TC.Restaurant.survey_questions().add(TC.Restaurant.data.survey_questions);
  	
  	var carousel = survey.down('#tcSurveySliderCarouselId');
		var questions_per_page = 4;
		var question_counter = 0;
		
		var survey_pages = [];
		var survey_questions = null;
  	
    TC.Restaurant.survey_questions().each(function(question){
			if(question_counter%questions_per_page==0){
				survey_questions = Ext.create('TC.view.survey.basic.SurveyQuestions');
				survey_questions.setStore(Ext.create('TC.store.SurveyQuestions'));
				var survey_page = Ext.create('TC.view.survey.slider.SurveyPage',{
					// first_page: (survey_pages.length==0)
				});
				survey_page.insert(0,survey_questions);
				survey_pages.push(survey_page);
			}
			survey_questions.getStore().add(question);
			question_counter++;
    });
    	
    carousel.setItems(survey_pages);
    carousel.add(Ext.create('TC.view.survey.slider.SurveyOpinion'));
    
    // if(survey_pages.length<2){
    	// carousel.setIndicator(false);
    // }
    
    carousel.setActiveItem(0);
  },
  
  
  showSurvey: function(survey){
  	console.log('TC.controller.SliderSurvey.showSurvey');
  	this.setupSurvey(survey);
  	var me = this;
  	if(TC.SentOrderItems && TC.SentOrderItems.getCount()>0){
  		// setting order items and questions
	  	survey.down('survey-dishes').setStore(TC.SentOrderItems);
	  	// setting scrollbar visible if needed
	  	var items = TC.SentOrderItems.getCount();
			if(items>4){
				$j(survey.down('survey-dishes').element.dom).find('.x-scroll-indicator-dark.x-scroll-indicator.x-scroll-indicator-x').css('opacity','0.5 !important');
			}
			// setting placeholders
	  	$j('.tcSurveyDishes .survey_dish_comment').each(function(){
	  		var placeholder = $j(this).attr('placeholder');
	  		$j(this).watermark(placeholder, {fallback: false});
	  	});
  	}
  	// lets bind stuff
  	$z(document).on($tc.click, '.tcSurveySliderContainer .rating .star', me.rate);
  	$z(document).on($tc.click, '.tcSurveySliderContainer .survey_question .x-segmentedbutton .x-button', me.selectAnswer);
  },
  
  selectAnswer: function(event,a,b){
  	console.log('TC.controller.BasicSurvey.selectAnswer');
  	var selectedOption = event.target;
		var selectedClass = 'x-button-pressed';
		$j(selectedOption).addClass(selectedClass);
  	$j(selectedOption).siblings().removeClass(selectedClass);
  },
  
  rate: function(event,a,b){
  	console.log('TC.controller.BasicSurvey.rate');
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
  },
  
  loadSurvey: function(){
  	console.log('TC.controller.survey.SliderSurvey.loadSurvey');
  	TC.switchView({xtype: 'survey-slider-container'});
  }
  
});
