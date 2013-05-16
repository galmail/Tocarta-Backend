# == Schema Information
#
# Table name: menu_settings
#
#  id                 :integer          not null, primary key
#  menu_id            :integer
#  name               :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  active             :boolean
#  priority           :integer
#  trigger_activation :datetime
#  last_time_changed  :datetime
#  from_day           :string(255)
#  to_day             :string(255)
#  from_time          :time
#  to_time            :time
#

require 'test_helper'

class MenuSettingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
