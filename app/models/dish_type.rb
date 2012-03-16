class DishType < ActiveRecord::Base
	has_many :dish_type_associations
	has_many :dishes, :through => :dish_type_associations
	has_attached_file :icon,:path => "img/dish_types/dish_type_:id.:extension"
	translates :name, :fallbacks_for_empty_translations => true
	attr_accessible :position, :dish_class
end
