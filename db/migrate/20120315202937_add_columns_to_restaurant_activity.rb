class AddColumnsToRestaurantActivity < ActiveRecord::Migration
  def change
    add_column :restaurant_activities, :ack, :timestamp

  end
end
