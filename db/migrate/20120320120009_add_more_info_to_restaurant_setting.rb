class AddMoreInfoToRestaurantSetting < ActiveRecord::Migration
  def change
    add_column :restaurant_settings, :multilang_homepage, :boolean, :default => false

    add_column :restaurant_settings, :games, :boolean, :default => false

    add_column :restaurant_settings, :call_waiter_button, :boolean, :default => true

    add_column :restaurant_settings, :order_button, :boolean, :default => true

    add_column :restaurant_settings, :request_bill_button, :boolean, :default => true

    add_column :restaurant_settings, :show_help_button, :boolean, :default => true

    add_column :restaurant_settings, :show_survey, :boolean, :default => true

  end
end
