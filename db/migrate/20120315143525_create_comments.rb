class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :dish
      t.references :restaurant
      t.references :client
      t.references :survey_question
      t.string :name

      t.timestamps
    end
    add_index :comments, :dish_id
    add_index :comments, :restaurant_id
    add_index :comments, :client_id
    add_index :comments, :survey_question_id
  end
end
