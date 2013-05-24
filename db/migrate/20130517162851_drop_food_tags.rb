class DropFoodTags < ActiveRecord::Migration
  def up
    begin
      drop_table :food_tags if self.table_exists?("food_tags")
      FoodTag.drop_translation_table!
    rescue
      
    end
  end
end
