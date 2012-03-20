class ChangeColumnToDish < ActiveRecord::Migration
  def up
    change_column :dishes, :rating, :decimal
  end

  def down
  end
end
