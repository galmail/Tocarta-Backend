class CreateDishsFoodTagsTable < ActiveRecord::Migration
  def up
    create_table :dishes_food_tags, :id => false do |t|
      t.column :dish_id,     :integer
      t.column :food_tag_id, :integer
    end
    add_index :dishes_food_tags, [:dish_id, :food_tag_id]
    add_index :dishes_food_tags, [:food_tag_id, :dish_id]
  end

  def down
    drop_table :dishes_food_tags
  end
end
