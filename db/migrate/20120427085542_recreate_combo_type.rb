class RecreateComboType < ActiveRecord::Migration
  def up
    drop_table :combo_types if self.table_exists?("combo_types")
    create_table :combo_types do |t|
      t.references :restaurant
      t.string :name
      t.boolean :active
      t.integer :position
      t.decimal :price
      t.text :description
      t.timestamps
    end
    add_index :combo_types, :restaurant_id
    ComboType.create_translation_table! :name => :string, :description => :text
  end
  
  def down
    ComboType.drop_translation_table!
  end
end
