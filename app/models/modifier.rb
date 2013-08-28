class Modifier < ActiveRecord::Base
  belongs_to  :restaurant
  belongs_to  :modifier_list
  
  attr_accessible :name, :sd_modifierid, :description, :price
  attr_accessible :restaurant_id, :modifier_list_id
end
