class ModifierListSetAssociation < ActiveRecord::Base
  belongs_to :modifier_list
  belongs_to :modifier_list_set
  
  attr_accessible :modifier_list_id, :modifier_list_set_id
  
  #validates :modifier_list_id, :uniqueness => { :scope => [:modifier_list_set_id] }
  validates_uniqueness_of :modifier_list_id, :scope => :modifier_list_set_id
  
end
