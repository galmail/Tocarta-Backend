class Menu < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :theme
	has_one :menu_setting
	has_many :sections
	attr_accessible :price, :menu_type
end
