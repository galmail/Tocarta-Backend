class FixNameForWaiter < ActiveRecord::Migration
  def up
    remove_column :waiters, :first_name
    remove_column :waiters, :middle_name
    remove_column :waiters, :last_name
    add_column :waiters, :name, :string
  end

  def down
    add_column :waiters, :first_name
    add_column :waiters, :middle_name
    add_column :waiters, :last_name
    remove_column :waiters, :name
  end
end
