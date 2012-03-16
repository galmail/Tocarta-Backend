class AddColumnsToMenu < ActiveRecord::Migration
  def change
    add_column :menus, :price, :decimal

    add_column :menus, :menu_type, :string

  end
end
