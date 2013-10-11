class LinkAppToWaiter < ActiveRecord::Migration
  def up
    change_table :waiters do |t|
      t.references :waiter_app
    end
    add_index :waiters, :waiter_app_id
  end
  
  def down
    remove_column :waiters, :waiter_app_id
  end
end
