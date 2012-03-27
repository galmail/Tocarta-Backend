class ChangeColumnActiveToDish < ActiveRecord::Migration
  def up
    change_column :dishes, :active, :boolean, :default => true
  end

  def down
  end
end
