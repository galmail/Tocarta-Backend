class CreateModifierLists < ActiveRecord::Migration
  def change
    create_table :modifier_lists do |t|
      t.references  :restaurant
      t.string      :name
      t.boolean     :is_mandatory, :default => false
      t.boolean     :is_multioption, :default => false
      t.timestamps
    end
    add_index :modifier_lists, :restaurant_id
  end
end
