class Table < ActiveRecord::Base
  belongs_to :restaurant
	has_many :tablets
	has_many :orders
	has_many :restaurant_activities
	attr_accessible :name, :number, :status, :dinners, :language
end
