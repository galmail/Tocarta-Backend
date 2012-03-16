class CreateRestaurantActivities < ActiveRecord::Migration
  def change
    create_table :restaurant_activities do |t|
      t.references :restaurant
      t.references :table
      t.references :order
      t.string :name

      t.timestamps
    end
    add_index :restaurant_activities, :restaurant_id
    add_index :restaurant_activities, :table_id
    add_index :restaurant_activities, :order_id
  end
end
