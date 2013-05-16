# == Schema Information
#
# Table name: combos
#
#  id            :integer          not null, primary key
#  combo_type_id :integer
#  restaurant_id :integer
#  name          :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'test_helper'

class ComboTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
