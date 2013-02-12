class RestaurantSetting < ActiveRecord::Base
  belongs_to :restaurant
	attr_accessible :name, :num_licenses, :default_language, :last_menu_sync, :access_key
	attr_accessible :multilang_homepage, :games, :call_waiter_button, :order_button, :request_bill_button, :show_help_button, :show_survey, :show_filters
	attr_accessible :restaurant_id
	
	### Validations ###
	
	validates :num_licenses, :restaurant_id, :access_key, :presence => true
	validates :access_key, :length => { :is => 4 }	  
	
end
