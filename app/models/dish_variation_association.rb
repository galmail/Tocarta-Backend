class DishVariationAssociation < ActiveRecord::Base
  belongs_to :dish_variation
  belongs_to :dish
end
