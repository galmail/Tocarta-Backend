class Order < ActiveRecord::Base
  belongs_to :tablet
  belongs_to :client
	has_many :order_items
	has_many :restaurant_activities
	attr_accessible :note
end
