class RemoveColumnComboFromDishes < ActiveRecord::Migration
  def up
    remove_column :dishes, :combo_id
  end
  def down
    change_table :dishes do |t|
      t.references :combo
    end
    add_index :dishes, :combo_id
  end
end
