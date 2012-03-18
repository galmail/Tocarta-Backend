class RestaurantSetting < ActiveRecord::Base
  belongs_to :restaurant
	attr_accessible :name, :num_licenses, :default_language, :last_menu_sync, :restaurant_id
end
