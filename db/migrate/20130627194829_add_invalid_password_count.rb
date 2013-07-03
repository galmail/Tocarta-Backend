class AddInvalidPasswordCount < ActiveRecord::Migration
  def up
    add_column :users, :invalid_password_count, :integer, default: 0
  end

  def down
    remove_column :users, :invalid_password_count
  end
end
