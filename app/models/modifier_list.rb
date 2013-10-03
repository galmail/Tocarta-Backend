class ModifierList < ActiveRecord::Base
  include Utils
  before_save :generate_sid
  
  belongs_to  :restaurant
  has_many :modifiers
  
  has_many :modifier_list_sets, :through => :modifier_list_set_associations
  has_many :modifier_list_set_associations
  attr_accessible :modifier_list_set_ids
  
  attr_accessible :name, :is_mandatory, :is_multioption, :modifier_ids, :sid
  attr_accessible :restaurant_id
  
end
