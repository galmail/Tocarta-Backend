# == Schema Information
#
# Table name: skins
#
#  id                      :integer          not null, primary key
#  theme_id                :integer
#  name                    :string(255)
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  description             :text
#  stylesheet_file_name    :string(255)
#  stylesheet_content_type :string(255)
#  stylesheet_file_size    :integer
#  stylesheet_updated_at   :datetime
#  user_id                 :integer
#

require 'test_helper'

class SkinTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
