class DropFoodTags < ActiveRecord::Migration
  def up
    drop_table :food_tags
    # FoodTag.drop_translation_table!
  end
end
