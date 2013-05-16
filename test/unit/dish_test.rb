# == Schema Information
#
# Table name: dishes
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#  active             :boolean          default(TRUE)
#  position           :integer
#  description        :text
#  price              :decimal(, )
#  rating             :decimal(, )
#  reviews            :integer
#  story              :text
#  video              :string(255)
#  nutrition_facts    :string(255)
#  badge_name         :string(255)
#  short_title        :string(255)
#  rate_me            :boolean          default(TRUE)
#  chain_id           :integer
#

require 'test_helper'

class DishTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
