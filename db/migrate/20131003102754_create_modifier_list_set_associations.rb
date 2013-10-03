class CreateModifierListSetAssociations < ActiveRecord::Migration  
  def change
    create_table :modifier_list_set_associations do |t|
      t.references :modifier_list
      t.references :modifier_list_set
    end
    add_index :modifier_list_set_associations, :modifier_list_id
    add_index :modifier_list_set_associations, :modifier_list_set_id
  end
end
