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

  def last_week_rating_diff(restaurant_id)
    last_week_range = (2.week.ago..1.week.ago)
    this_week_range = (1.week.ago..Time.now)
    last = self.comments.by_restaurant(restaurant_id).where(created_at: last_week_range).average(:rating)
    this = self.comments.by_restaurant(restaurant_id).where(created_at: this_week_range).average(:rating)

    last = last.blank? ? 0.1 : last
    this = this.blank? ? 0.1 : this

    result = (this - last) * 100.0 / last
    result = result >= 0 ? result : 0.0
  end

  def update_rating_average!
    rate = self.comments.average(:rating)
    self.rating = rate.blank? ? 0 : rate
    self.save
  end
end


