class CreateDishsIngredientsTable < ActiveRecord::Migration
  def up
    create_table :dishes_ingredients, :id => false do |t|
      t.column :dish_id,     :integer
      t.column :ingredient_id, :integer
    end
    add_index :dishes_ingredients, [:dish_id, :ingredient_id]
    add_index :dishes_ingredients, [:ingredient_id, :dish_id]
  end

  def down
    drop_table :dishes_ingredients
  end
end
