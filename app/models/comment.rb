class Comment < ActiveRecord::Base
  belongs_to :dish
  belongs_to :restaurant
  belongs_to :client
  belongs_to :survey_question
	attr_accessible :description, :rating, :approved
end
