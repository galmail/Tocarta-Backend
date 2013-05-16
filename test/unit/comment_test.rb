# == Schema Information
#
# Table name: comments
#
#  id                 :integer          not null, primary key
#  dish_id            :integer
#  restaurant_id      :integer
#  client_id          :integer
#  survey_question_id :integer
#  name               :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  description        :text
#  rating             :integer
#  approved           :boolean          default(TRUE)
#

require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
