# == Schema Information
#
# Table name: orders
#
#  id         :integer          not null, primary key
#  tablet_id  :integer
#  client_id  :integer
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  note       :string(255)
#  table_id   :integer
#  total      :decimal(, )
#  language   :string(255)
#

require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
