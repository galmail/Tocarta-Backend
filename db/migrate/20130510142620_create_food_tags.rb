class CreateFoodTags < ActiveRecord::Migration
  def up
    create_table :food_tags do |t|
      t.string :name
      t.timestamps
    end
    FoodTag.create_translation_table! :name => :string
  end

  def down
    drop_table :food_tags
    FoodTag.drop_translation_table!
  end
end
