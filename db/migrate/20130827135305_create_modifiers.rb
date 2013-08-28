class CreateModifiers < ActiveRecord::Migration
  def change
    create_table :modifiers do |t|
      t.references  :restaurant
      t.string      :name
      t.integer     :sd_modifierid
      t.timestamps
    end
    add_index :modifiers, :restaurant_id
  end
end
