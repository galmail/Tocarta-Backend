class ModifierListSetAssociation < ActiveRecord::Base
  belongs_to :modifier_list
  belongs_to :modifier_list_set
  
  # attr_accessible :title, :body
  
end
