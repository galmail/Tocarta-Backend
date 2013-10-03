class ModifierListSet < ActiveRecord::Base
  include Utils
  before_save :generate_sid
  
  belongs_to  :restaurant
  has_many :dishes
  
  has_many :modifier_lists, :through => :modifier_list_set_associations
  has_many :modifier_list_set_associations
  attr_accessible :modifier_list_ids
  
  attr_accessible :name, :sid
  attr_accessible :dish_ids, :restaurant_id
  
  
end
