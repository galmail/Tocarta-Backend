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
#  rating             :integer
#  approved           :boolean          default(TRUE)
#

class Comment < ActiveRecord::Base
  # include MongohqLogger
  belongs_to :dish
  belongs_to :restaurant
  belongs_to :client
  belongs_to :survey_question
  attr_accessible :name, :description, :rating, :approved
  attr_accessible :dish_id, :restaurant_id
  # after_save :logme

  # TODO capture everytime the comment is approved (or disapproved) and update dish rating
  scope :without_dish,    where(dish_id: nil)
  scope :with_dish,       joins(:dish)
  scope :newest,          order('created_at DESC').limit(10)

  def self.by_dish(id)
    where(dish_id: id)
  end

  def self.to_dish_rating_array(comments)
    comments.inject([]) do |r, v|
      r << [v.dish.name, v.dish.rating.to_i, v.rating]
      r
    end
  end

end
