class RestaurantSetting < ActiveRecord::Base
  belongs_to :restaurant
	attr_accessible :name, :num_licenses, :default_language, :last_menu_sync
	attr_accessible :multilang_homepage, :games, :call_waiter_button, :order_button, :request_bill_button, :show_help_button, :show_survey
	attr_accessible :restaurant_id
end
