class AddKeyToWaiters < ActiveRecord::Migration
  
  def up
    add_column(:waiters, :key, :string)
    add_column(:waiters, :active, :boolean, :default => true)
  end

  def down
    remove_column(:waiters, :key)
    remove_column(:waiters, :active)
  end

end
