class AddColumnsToModifierListSet < ActiveRecord::Migration
  def change
    change_table :modifier_list_sets do |t|
      t.references :restaurant
      t.string :name
      t.string :sid
    end
    add_index :modifier_list_sets, :restaurant_id
  end
end
