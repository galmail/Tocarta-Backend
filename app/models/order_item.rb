class OrderItem < ActiveRecord::Base
  include MongohqLogger
  belongs_to :order
  belongs_to :dish
  belongs_to :combo
  belongs_to :combo_type
	attr_accessible :quantity, :note, :name
	
	after_save :logme
	
end
