# == Schema Information
#
# Table name: comments
#
#  id                 :integer          not null, primary key
#  dish_id            :integer
#  restaurant_id      :integer
#  client_id          :integer
#  tablet_id          :integer
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
  # include MongohqLogger
  belongs_to :dish
  belongs_to :restaurant
  belongs_to :client
  belongs_to :tablet
  belongs_to :survey_question
  attr_accessible :name, :description, :rating, :approved, :email
  attr_accessible :dish_id, :restaurant_id, :tablet_id
  # after_save :logme

  after_save :update_survey_rating,
    :if => Proc.new { |comment| comment.survey_question.present? }

  # TODO capture everytime the comment is approved (or disapproved) and update dish rating
  scope :without_dish,    where(dish_id: nil)
  scope :with_dish,       joins(:dish)
  scope :without_survey,  where(survey_question_id: nil)
  scope :with_survey,     joins(:survey_question)
  scope :newest,          order('created_at DESC').limit(10)

  def self.by_dish(id)
    where(dish_id: id)
  end

  def self.by_restaurant(id)
    where(restaurant_id: id)
  end

  # Create an array with comments
  # @param [Comment] coments
  # @return [Array] [Dish.name, Dish.rating, Comment.rating, Dish.comments]
  def self.to_dish_rating_array(comments)
    comments.inject([]) do |r, v|
      r << [v.dish.name, v.dish.rating.to_i, v.rating, v.dish.comments.count]
      r
    end
  end

  private

  def update_survey_rating
    self.survey_question.update_rating_average!
  end

end
