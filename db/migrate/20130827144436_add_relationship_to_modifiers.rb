class AddRelationshipToModifiers < ActiveRecord::Migration
  def up
    change_table :modifiers do |t|
      t.references :modifier_list
    end
    add_index :modifiers, :modifier_list_id
  end
  
  def down
    remove_column :modifiers, :modifier_list_id
  end
end
