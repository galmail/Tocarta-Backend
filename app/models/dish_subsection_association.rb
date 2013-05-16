# == Schema Information
#
# Table name: dish_subsection_associations
#
#  id            :integer          not null, primary key
#  dish_id       :integer
#  subsection_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class DishSubsectionAssociation < ActiveRecord::Base
  belongs_to :dish
  belongs_to :subsection
  
  validates_uniqueness_of :dish_id, :scope => :subsection_id
end
