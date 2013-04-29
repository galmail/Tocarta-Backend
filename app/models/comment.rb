class Comment < ActiveRecord::Base
  include MongohqLogger
  belongs_to :dish
  belongs_to :restaurant
  belongs_to :client
  belongs_to :survey_question
	attr_accessible :name, :description, :rating, :approved
	attr_accessible :dish_id, :restaurant_id
	after_save :logme
	
	# TODO capture everytime the comment is approved (or disapproved) and update dish rating
	
end
