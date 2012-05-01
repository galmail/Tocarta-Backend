class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :dish
  belongs_to :combo
  belongs_to :combo_type
	attr_accessible :quantity, :note, :name
end
