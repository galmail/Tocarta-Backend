# == Schema Information
#
# Table name: dish_subsection_associations
#
#  id            :integer          not null, primary key
#  dish_id       :integer
#  subsection_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'test_helper'

class DishSubsectionAssociationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
