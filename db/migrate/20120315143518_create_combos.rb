class CreateCombos < ActiveRecord::Migration
  def change
    create_table :combos do |t|
      t.references :combo_type
      t.references :restaurant
      t.string :name

      t.timestamps
    end
    add_index :combos, :combo_type_id
    add_index :combos, :restaurant_id
  end
end
