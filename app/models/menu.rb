class Menu < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :theme
	has_one :menu_setting
	has_many :sections
	attr_accessible :name, :price, :menu_type, :restaurant_id
end
