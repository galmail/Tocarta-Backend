class RestaurantSetting < ActiveRecord::Base
  belongs_to :restaurant
	attr_accessible :num_licenses, :default_language, :last_menu_sync
end
