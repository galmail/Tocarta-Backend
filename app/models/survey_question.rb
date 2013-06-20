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
    self.with_comments.merge( Comment.by_restaurant(id) )
  end

  def update_rating_average!
    num_comments = self.comments.length
    rate = self.comments.average(:rating)
    self.rating = rate.blank? ? 0 : rate
    self.save
  end
end


