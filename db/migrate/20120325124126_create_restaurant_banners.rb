class CreateRestaurantBanners < ActiveRecord::Migration
  def change
    create_table :restaurant_banners do |t|
      t.references :restaurant

      t.timestamps
    end
    add_index :restaurant_banners, :restaurant_id
  end
end
