class CreateDishModifierListAssociations < ActiveRecord::Migration
  def change
    create_table :dish_modifier_list_associations do |t|
      t.references :dish
      t.references :modifier_list
      t.timestamps
    end
    add_index :dish_modifier_list_associations, :dish_id
    add_index :dish_modifier_list_associations, :modifier_list_id
  end
end
