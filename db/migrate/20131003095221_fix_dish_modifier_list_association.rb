class FixDishModifierListAssociation < ActiveRecord::Migration
  def up
    # remove n-to-n table
    drop_table :dish_modifier_list_associations if self.table_exists?("dish_modifier_list_associations")
    # add dish relationship
    change_table :dishes do |t|
      t.references :modifier_list_set
    end
    add_index :dishes, :modifier_list_set_id
  end

  def down
    remove_column :dishes, :modifier_list_set_id
  end
end
