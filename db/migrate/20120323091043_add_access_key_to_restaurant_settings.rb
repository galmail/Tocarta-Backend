class AddAccessKeyToRestaurantSettings < ActiveRecord::Migration
  def change
    add_column :restaurant_settings, :access_key, :integer, :default => 1111

  end
end
