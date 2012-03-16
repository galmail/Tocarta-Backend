class CreateDishVariations < ActiveRecord::Migration
  def change
    create_table :dish_variations do |t|
      t.references :dish
      t.string :name

      t.timestamps
    end
    add_index :dish_variations, :dish_id
  end
end
