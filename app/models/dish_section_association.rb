# == Schema Information
#
# Table name: dish_section_associations
#
#  id         :integer          not null, primary key
#  dish_id    :integer
#  section_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class DishSectionAssociation < ActiveRecord::Base
  belongs_to :dish
  belongs_to :section
  
  validates_uniqueness_of :dish_id, :scope => :section_id
end
