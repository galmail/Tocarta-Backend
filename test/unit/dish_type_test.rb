# == Schema Information
#
# Table name: dish_types
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  icon_file_name    :string(255)
#  icon_content_type :string(255)
#  icon_file_size    :integer
#  icon_updated_at   :datetime
#  position          :integer
#  dish_class        :string(255)
#  description       :string(255)
#

require 'test_helper'

class DishTypeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
