class RemoveColumnComboFromDishes < ActiveRecord::Migration
  def up
    remove_column :dishes, :combo_id
  end
  def down
    add_column :dishes, :combo_id
  end
end
