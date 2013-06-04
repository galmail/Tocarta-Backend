# == Schema Information
#
# Table name: dashboards
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  options    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Dashboard < ActiveRecord::Base
  attr_accessible :name, :options
  serialize :options
  validates :name, presence: true, uniqueness: true
end
