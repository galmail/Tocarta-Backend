class DishVariation < ActiveRecord::Base
  belongs_to :dish
	has_attached_file :photo,:path => "img/dish_variations/dish_variation_:id.:extension"
	translates :name, :fallbacks_for_empty_translations => true
	attr_accessible :price
end
