# == Schema Information
#
# Table name: dish_variations
#
#  id                    :integer          not null, primary key
#  dish_variation_set_id :integer
#  name                  :string(255)
#  active                :boolean
#  position              :integer
#  price                 :decimal(, )
#  description           :text
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

require 'test_helper'

class DishVariationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
