class CreateSurveyQuestions < ActiveRecord::Migration
  def change
    create_table :survey_questions do |t|
      t.references :chain
      t.string :name

      t.timestamps
    end
    add_index :survey_questions, :chain_id
  end
end
