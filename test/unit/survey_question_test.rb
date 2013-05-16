# == Schema Information
#
# Table name: survey_questions
#
#  id          :integer          not null, primary key
#  chain_id    :integer
#  name        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :text
#  position    :integer
#  active      :boolean          default(TRUE)
#  yes_no_type :boolean          default(FALSE)
#

require 'test_helper'

class SurveyQuestionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
