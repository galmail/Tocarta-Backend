class Combo < ActiveRecord::Base
  belongs_to :combo_type
  belongs_to :restaurant
	has_many :order_items
	has_many :dishes, :through => :dish_combo_associations
  has_many :dish_combo_associations
	attr_accessible :name, :dish_ids
end
