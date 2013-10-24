class AddRoleToWaiter < ActiveRecord::Migration
  def change
    add_column :waiters, :role, :string
  end
end
