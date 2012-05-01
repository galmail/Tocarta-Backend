class Combo < ActiveRecord::Base
  belongs_to :combo_type
  belongs_to :restaurant
	has_many :dishes
	has_many :order_items
	attr_accessible :name
end
