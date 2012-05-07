class AddColumnsActivationsToMenuSetting < ActiveRecord::Migration
  def change
    add_column :menu_settings, :from_day, :string
    add_column :menu_settings, :to_day, :string
    add_column :menu_settings, :from_time, :time
    add_column :menu_settings, :to_time, :time
  end
end
