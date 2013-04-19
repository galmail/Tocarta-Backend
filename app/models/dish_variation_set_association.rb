class DishVariationSetAssociation < ActiveRecord::Base
  belongs_to :dish_variation_set
  belongs_to :dish
end
