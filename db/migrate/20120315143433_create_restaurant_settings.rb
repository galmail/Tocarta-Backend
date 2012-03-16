class CreateRestaurantSettings < ActiveRecord::Migration
  def change
    create_table :restaurant_settings do |t|
      t.references :restaurant
      t.string :name

      t.timestamps
    end
    add_index :restaurant_settings, :restaurant_id
  end
end
