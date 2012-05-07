class DishComboAssociation < ActiveRecord::Base
  belongs_to :dish
  belongs_to :combo
  
  validates_uniqueness_of :dish_id, :scope => :combo_id
end
