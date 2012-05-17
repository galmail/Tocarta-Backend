class AddColumnDescriptionToDishTypes < ActiveRecord::Migration
  def up
    add_column :dish_types, :description, :string
    DishType.create_translation_table! :description => :string
  end
  
  def down
    remove_column :dish_types, :description
    DishType.drop_translation_table!
  end
end
