class DishTypeAssociation < ActiveRecord::Base
  belongs_to :dish_type
  belongs_to :dish
end
