class AddYesNoTypeToSurveyQuestions < ActiveRecord::Migration
  def change
    add_column :survey_questions, :yes_no_type, :boolean, :default => false
  end
end
