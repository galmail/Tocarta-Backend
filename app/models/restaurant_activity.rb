class RestaurantActivity < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :table
  belongs_to :order
	attr_accessible :ack
end
