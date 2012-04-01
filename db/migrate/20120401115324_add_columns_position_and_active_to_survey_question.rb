class AddColumnsPositionAndActiveToSurveyQuestion < ActiveRecord::Migration
  def change
    add_column :survey_questions, :position, :integer

    add_column :survey_questions, :active, :boolean, :default => true

  end
end
