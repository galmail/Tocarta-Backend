# == Schema Information
#
# Table name: dish_combo_associations
#
#  id         :integer          not null, primary key
#  dish_id    :integer
#  combo_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class DishComboAssociation < ActiveRecord::Base
  belongs_to :dish
  belongs_to :combo
  
  validates_uniqueness_of :dish_id, :scope => :combo_id
end
