# == Schema Information
#
# Table name: restaurants
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  chain_id   :integer
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  manager    :string(255)
#  email      :string(255)
#  address    :string(255)
#  phone      :string(255)
#  note       :text
#

require 'test_helper'

class RestaurantTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
