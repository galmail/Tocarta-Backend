class Table < ActiveRecord::Base
  belongs_to :restaurant
	has_many :tablets
	has_many :restaurant_activities
	attr_accessible :number,:status
end
