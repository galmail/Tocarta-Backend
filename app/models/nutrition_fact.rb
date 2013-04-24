class NutritionFact < ActiveRecord::Base
  belongs_to :dish
  attr_accessible :calories, :carbs, :fats, :cholesterol, :proteins, :dish_id
end
