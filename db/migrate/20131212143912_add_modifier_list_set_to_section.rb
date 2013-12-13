class AddModifierListSetToSection < ActiveRecord::Migration
  def up
    change_table :sections do |t|
      t.references :modifier_list_set
    end
    add_index :sections, :modifier_list_set_id
  end
  
  def down
    remove_column :sections, :modifier_list_set_id
  end
end
