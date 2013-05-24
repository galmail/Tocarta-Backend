# == Schema Information
#
# Table name: restaurant_settings
#
#  id                  :integer          not null, primary key
#  restaurant_id       :integer
#  name                :string(255)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  num_licenses        :integer
#  default_language    :string(255)
#  last_menu_sync      :datetime
#  multilang_homepage  :boolean          default(FALSE)
#  games               :boolean          default(FALSE)
#  call_waiter_button  :boolean          default(TRUE)
#  order_button        :boolean          default(TRUE)
#  request_bill_button :boolean          default(TRUE)
#  show_help_button    :boolean          default(TRUE)
#  show_survey         :boolean          default(TRUE)
#  access_key          :integer          default(1111)
#  show_filters        :boolean          default(FALSE)
#  supported_lang      :string(255)
#

require 'test_helper'

class RestaurantSettingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
