# node(:modifiers) { |m| @modifier_lists }

child @modifier_lists do
  attributes :id, :name, :is_mandatory, :is_multioption
  
  child :dish_modifier_list_associations => :dishes do
    attributes :id, :dish_id
  end
  
  child :modifiers => :modifiers do
    attributes :id, :name, :sd_modifierid, :description, :price
  end
end


