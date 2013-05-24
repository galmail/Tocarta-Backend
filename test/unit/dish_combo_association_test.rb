# == Schema Information
#
# Table name: dish_combo_associations
#
#  id         :integer          not null, primary key
#  dish_id    :integer
#  combo_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class DishComboAssociationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
