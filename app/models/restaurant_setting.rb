class RestaurantSetting < ActiveRecord::Base
  belongs_to :restaurant
	serialize :supported_lang, Array
	attr_accessible :name, :num_licenses, :default_language, :last_menu_sync, :access_key, :supported_lang
	attr_accessible :multilang_homepage, :games, :call_waiter_button, :order_button, :request_bill_button, :show_help_button, :show_survey, :show_filters
	attr_accessible :restaurant_id
	
	def supported_lang_enum
    [ [ 'English', "en" ], [ 'French', "fr" ], [ 'Spanish', "es" ], [ 'Catalan', "cat" ] ]
  end
	
	### Validations ###
	
	validates :num_licenses, :restaurant_id, :access_key, :presence => true
	validates :access_key, :length => { :is => 4 }	  
	
end
