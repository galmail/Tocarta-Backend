class DishSectionAssociation < ActiveRecord::Base
  belongs_to :dish
  belongs_to :section
  
  validates_uniqueness_of :dish_id, :scope => :section_id
end
