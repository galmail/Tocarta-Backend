class AddRatingToSurveyQuestion < ActiveRecord::Migration
  def up
    change_table :survey_questions do |t|
      t.decimal :rating, default: 0
    end
  end
  def down
    remove_column :survey_questions, :rating
  end
end
