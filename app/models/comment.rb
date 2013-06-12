# == Schema Information
#
# Table name: comments
#
#  id                 :integer          not null, primary key
#  dish_id            :integer
#  restaurant_id      :integer
#  client_id          :integer
#  survey_question_id :integer
#  name               :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  description        :text
#  email              :string(255)
#  rating             :integer
#  approved           :boolean          default(TRUE)
#

class Comment < ActiveRecord::Base
  include MongohqLogger
  belongs_to :dish
  belongs_to :restaurant
  belongs_to :client
  belongs_to :survey_question
	attr_accessible :name, :description, :rating, :approved, :email
	attr_accessible :dish_id, :restaurant_id
	after_save :logme
	
	# TODO capture everytime the comment is approved (or disapproved) and update dish rating
	
end
