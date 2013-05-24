# == Schema Information
#
# Table name: dish_variation_set_associations
#
#  id                    :integer          not null, primary key
#  dish_variation_set_id :integer
#  dish_id               :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class DishVariationSetAssociation < ActiveRecord::Base
  belongs_to :dish_variation_set
  belongs_to :dish
end
