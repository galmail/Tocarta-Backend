child @modifier_list_sets do
  attributes :id, :name
  
  parent_mlistset = nil
  node :sid do |modifier_list_set|
    parent_mlistset = modifier_list_set
    modifier_list_set.sid
  end
  
  child :dishes => :dishes do
    attributes :id, :sid
  end
  
  child :modifier_lists => :modifier_lists do
    attributes :id, :name, :is_mandatory, :is_multioption
    
    node :sid do |modifier_list|
      modifier_list.complex_sid(parent_mlistset)
    end
    
    node :selected_modifier_sid do |mlist|
      if mlist.selected_modifier
        mlist.selected_modifier.complex_sid(parent_mlistset)
      end
    end
    
    child :modifiers => :modifiers do
      attributes :id, :name, :sd_modifierid, :description, :price
      
      node :sid do |modifier|
        modifier.complex_sid(parent_mlistset)
      end
      
    end
  end
  
end


