class DishSubsectionAssociation < ActiveRecord::Base
  belongs_to :dish
  belongs_to :subsection
  
  validates_uniqueness_of :dish_id, :scope => :subsection_id
end
