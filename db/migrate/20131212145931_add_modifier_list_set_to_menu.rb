class AddModifierListSetToMenu < ActiveRecord::Migration
  
  def up
    change_table :menus do |t|
      t.references :modifier_list_set
    end
    add_index :menus, :modifier_list_set_id
  end
  
  def down
    remove_column :menus, :modifier_list_set_id
  end
  
end
