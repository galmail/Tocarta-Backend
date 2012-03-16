class AddColumnsToTablet < ActiveRecord::Migration
  def change
    add_column :tablets, :active, :boolean

    add_column :tablets, :access_key, :string

    add_column :tablets, :display_size, :string

    add_column :tablets, :device_brand, :string

    add_column :tablets, :device_name, :string

    add_column :tablets, :device_os, :string

    add_column :tablets, :last_menu_sync, :datetime

  end
end
