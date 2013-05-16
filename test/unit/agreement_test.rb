# == Schema Information
#
# Table name: agreements
#
#  id          :integer          not null, primary key
#  rol         :string(255)
#  locale      :string(255)
#  revision    :integer
#  title       :string(255)
#  description :string(255)
#  content     :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class AgreementTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
