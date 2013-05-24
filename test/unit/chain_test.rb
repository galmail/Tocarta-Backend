# == Schema Information
#
# Table name: chains
#
#  id                  :integer          not null, primary key
#  user_id             :integer
#  name                :string(255)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  logo_file_name      :string(255)
#  logo_content_type   :string(255)
#  logo_file_size      :integer
#  logo_updated_at     :datetime
#  email               :string(255)
#  address             :string(255)
#  note                :text
#  i18nbg_file_name    :string(255)
#  i18nbg_content_type :string(255)
#  i18nbg_file_size    :integer
#  i18nbg_updated_at   :datetime
#  bg_file_name        :string(255)
#  bg_content_type     :string(255)
#  bg_file_size        :integer
#  bg_updated_at       :datetime
#

require 'test_helper'

class ChainTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
