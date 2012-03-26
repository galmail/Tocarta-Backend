class AddIndexToRestaurantActivities < ActiveRecord::Migration
  def change
    add_index :restaurant_activities, :created_at
  end
end
