# == Schema Information
#
# Table name: dish_variations
#
#  id                    :integer          not null, primary key
#  dish_variation_set_id :integer
#  name                  :string(255)
#  active                :boolean
#  position              :integer
#  price                 :decimal(, )
#  description           :text
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class DishVariation < ActiveRecord::Base
  belongs_to :dish_variation_set
  
  # has_many :dish_variation_associations
  # has_many :dishes, :through => :dish_variation_associations
	# has_attached_file :photo, :path => "common/img/dish_variations/dish_variation_:id.:extension"
	translates :name, :description, :fallbacks_for_empty_translations => true
	attr_accessible :name, :description, :price, :position, :active, :dish_variation_set_id
	
end
