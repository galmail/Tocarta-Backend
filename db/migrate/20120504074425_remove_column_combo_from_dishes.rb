class RemoveColumnComboFromDishes < ActiveRecord::Migration
  def change
    remove_column :dishes, :combo_id
  end
end
