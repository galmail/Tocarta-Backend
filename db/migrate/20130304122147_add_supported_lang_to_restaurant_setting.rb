class AddSupportedLangToRestaurantSetting < ActiveRecord::Migration
  def change
    add_column :restaurant_settings, :supported_lang, :string
  end
end
