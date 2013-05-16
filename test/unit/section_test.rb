# == Schema Information
#
# Table name: sections
#
#  id                 :integer          not null, primary key
#  menu_id            :integer
#  name               :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#  active             :boolean          default(TRUE)
#  position           :integer
#  hasBigSubsections  :boolean          default(FALSE)
#  dishes_per_page    :integer          default(0)
#

require 'test_helper'

class SectionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
