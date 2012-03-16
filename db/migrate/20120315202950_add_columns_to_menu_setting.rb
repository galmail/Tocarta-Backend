class AddColumnsToMenuSetting < ActiveRecord::Migration
  def change
    add_column :menu_settings, :active, :boolean

    add_column :menu_settings, :priority, :integer

    add_column :menu_settings, :trigger_activation, :datetime

    add_column :menu_settings, :last_time_changed, :datetime

  end
end
