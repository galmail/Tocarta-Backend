child @modifier_list_sets do
  attributes :id, :sid, :name
  
  child :dishes => :dishes do
    attributes :id, :sid
  end
  
  child :modifier_lists => :modifier_lists do
    attributes :id, :sid, :name, :is_mandatory, :is_multioption
    
    child :modifiers => :modifiers do
      attributes :id, :sid, :name, :sd_modifierid, :description, :price
    end
  end
  
end


