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

require 'test_helper'

class NutritionFactTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
