class AddModifierListSetToSubsection < ActiveRecord::Migration
  
  def up
    change_table :subsections do |t|
      t.references :modifier_list_set
    end
    add_index :subsections, :modifier_list_set_id
  end
  
  def down
    remove_column :subsections, :modifier_list_set_id
  end

end
