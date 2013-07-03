class AddSyncToRestaurantSetting < ActiveRecord::Migration
  def change
    add_column :restaurant_settings, :sync_photos, :boolean
  end
end
