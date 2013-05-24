class DropFoodTags < ActiveRecord::Migration
  def up
    begin
      drop_table :food_tags if self.table_exists?("combo_types")
      FoodTag.drop_translation_table!
    rescue
      
    end
  end
end
