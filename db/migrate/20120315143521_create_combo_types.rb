class CreateComboTypes < ActiveRecord::Migration
  def change
    create_table :combo_types do |t|
      t.references :restaurant
      t.string :name

      t.timestamps
    end
    add_index :combo_types, :restaurant_id
  end
end
