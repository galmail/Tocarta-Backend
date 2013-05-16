# == Schema Information
#
# Table name: nutrition_facts
#
#  id          :integer          not null, primary key
#  dish_id     :integer
#  calories    :integer
#  fats        :integer
#  carbs       :integer
#  proteins    :integer
#  cholesterol :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class NutritionFact < ActiveRecord::Base
  belongs_to :dish
  attr_accessible :calories, :carbs, :fats, :cholesterol, :proteins, :dish_id
end
