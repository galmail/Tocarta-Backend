class DishModifierListAssociation < ActiveRecord::Base
  belongs_to :dish
  belongs_to :modifier_list
  
  validates_uniqueness_of :dish_id, :scope => :modifier_list_id
end
