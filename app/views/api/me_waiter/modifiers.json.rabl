child @modifier_list_sets do
  attributes :id, :sid, :name
  
  child :dishes => :dishes do
    attributes :id, :sid
  end
  
  child :modifier_lists => :modifier_lists do
    attributes :id, :sid, :name, :is_mandatory, :is_multioption
    
    #node(:selected_modifier_sid, :unless => lambda {|mlist| mlist.selected_modifier.nil? }) do |mlist|
    #  mlist.selected_modifier.sid
    #end
    
    node :selected_modifier_sid do |mlist|
      if mlist.selected_modifier
        mlist.selected_modifier.sid
      end
    end
    
    child :modifiers => :modifiers do
      attributes :id, :sid, :name, :sd_modifierid, :description, :price
    end
  end
  
end


