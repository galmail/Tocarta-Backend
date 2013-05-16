# == Schema Information
#
# Table name: restaurant_activities
#
#  id            :integer          not null, primary key
#  restaurant_id :integer
#  table_id      :integer
#  order_id      :integer
#  name          :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  ack           :datetime
#

require 'test_helper'

class RestaurantActivityTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
