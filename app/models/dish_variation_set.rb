# == Schema Information
#
# Table name: dish_variation_sets
#
#  id         :integer          not null, primary key
#  chain_id   :integer
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class DishVariationSet < ActiveRecord::Base
  belongs_to :chain
  has_many :dish_variations
  has_many :dish_variation_set_associations
  has_many :dishes, :through => :dish_variation_set_associations
	attr_accessible :name, :chain_id
	
end
