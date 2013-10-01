class AddSidToMenus < ActiveRecord::Migration
  def change
    add_column :menus, :sid, :string
  end
end
