class ModifierList < ActiveRecord::Base
  belongs_to  :restaurant
  has_many :modifiers
  
  has_many :dishes, :through => :dish_modifier_list_associations
  has_many :dish_modifier_list_associations
  attr_accessible :dish_ids
  
  attr_accessible :name, :is_mandatory, :is_multioption, :modifier_ids
  attr_accessible :restaurant_id
  
end
