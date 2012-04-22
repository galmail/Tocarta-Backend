class AddColumnsShowFiltersToRestaurantSetting < ActiveRecord::Migration
  def change
    add_column :restaurant_settings, :show_filters, :boolean, :default => false

  end
end
