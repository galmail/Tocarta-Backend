# == Schema Information
#
# Table name: tablets
#
#  id             :integer          not null, primary key
#  table_id       :integer
#  name           :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  active         :boolean
#  access_key     :string(255)
#  display_size   :string(255)
#  device_brand   :string(255)
#  device_name    :string(255)
#  device_os      :string(255)
#  last_menu_sync :datetime
#  activated      :boolean          default(FALSE)
#  alive          :datetime
#

require 'test_helper'

class TabletTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
