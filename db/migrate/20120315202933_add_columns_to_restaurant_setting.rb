class AddColumnsToRestaurantSetting < ActiveRecord::Migration
  def change
    add_column :restaurant_settings, :num_licenses, :integer

    add_column :restaurant_settings, :default_language, :string

    add_column :restaurant_settings, :last_menu_sync, :datetime

  end
end
