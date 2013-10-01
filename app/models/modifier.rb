class Modifier < ActiveRecord::Base
  include Utils
  before_save :generate_sid
  
  belongs_to  :restaurant
  belongs_to  :modifier_list
  
  attr_accessible :name, :sd_modifierid, :description, :price, :sid
  attr_accessible :restaurant_id, :modifier_list_id
end
