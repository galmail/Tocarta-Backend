class Comment < ActiveRecord::Base
  belongs_to :dish
  belongs_to :restaurant
  belongs_to :client
  belongs_to :survey_question
	attr_accessible :name, :description, :rating, :approved
	attr_accessible :dish_id, :restaurant_id
end
