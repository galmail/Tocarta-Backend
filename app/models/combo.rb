# == Schema Information
#
# Table name: combos
#
#  id            :integer          not null, primary key
#  combo_type_id :integer
#  restaurant_id :integer
#  name          :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Combo < ActiveRecord::Base
  # FIXME uncomment these lines after migration
  has_many :dishes, :through => :dish_combo_associations
  has_many :dish_combo_associations
  
  belongs_to :combo_type
  belongs_to :restaurant
	has_many :order_items
	attr_accessible :name, :dish_ids
end
