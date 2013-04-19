class DishVariation < ActiveRecord::Base
  belongs_to :dish_variation_set
  
  # has_many :dish_variation_associations
  # has_many :dishes, :through => :dish_variation_associations
	# has_attached_file :photo, :path => "common/img/dish_variations/dish_variation_:id.:extension"
	translates :name, :description, :fallbacks_for_empty_translations => true
	attr_accessible :name, :description, :price, :position, :active, :dish_variation_set_id
	
end
