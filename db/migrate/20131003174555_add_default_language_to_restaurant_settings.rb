class AddDefaultLanguageToRestaurantSettings < ActiveRecord::Migration
  def change
    change_column :restaurant_settings, :default_language, :string, :default => 'es'
  end
end
