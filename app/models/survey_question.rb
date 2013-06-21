# == Schema Information
#
# Table name: survey_questions
#
#  id          :integer          not null, primary key
#  chain_id    :integer
#  name        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :text
#  position    :integer
#  active      :boolean          default(TRUE)
#  yes_no_type :boolean          default(FALSE)
#

class SurveyQuestion < ActiveRecord::Base
  belongs_to :chain
  has_many :comments
  translates :name, :description, :fallbacks_for_empty_translations => true
  attr_accessible :name, :description, :position, :active, :yes_no_type, :chain_id

  scope :with_comments,    joins(:comments)
  scope :newest,          order('created_at DESC').limit(10)

  def self.by_restaurant(id)
    self.with_comments.merge( Comment.by_restaurant(id) ).uniq
  end

  # @param restaurant_id [Integer] the restaurant id
  # @return [Array] the rating values of each comment
  def newest_comments_by_restaurant_to_values(restaurant_id)
    self.comments.by_restaurant(restaurant_id).newest.pluck(:rating)
  end

  def last_week_avg_rating(restaurant_id, weeks = 1)
    time_range = (weeks.week.ago..Time.now)
    self.comments.by_restaurant(restaurant_id).where(created_at: time_range).average(:rating)
  end

  def update_rating_average!
    rate = self.comments.average(:rating)
    self.rating = rate.blank? ? 0 : rate
    self.save
  end
end


