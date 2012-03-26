class AddColumnsToRestaurantBanner < ActiveRecord::Migration
  def change
    add_column :restaurant_banners, :name, :string

    add_column :restaurant_banners, :position, :integer

    add_column :restaurant_banners, :active, :boolean, :default => true

  end
end
