# == Schema Information
#
# Table name: restaurant_banners
#
#  id                 :integer          not null, primary key
#  restaurant_id      :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#  name               :string(255)
#  position           :integer
#  active             :boolean          default(TRUE)
#

require 'test_helper'

class RestaurantBannerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
