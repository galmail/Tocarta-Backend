class CreateWaiterApps < ActiveRecord::Migration
  def change
    create_table :waiter_apps do |t|
      
      t.string :name
      t.string :version
      t.string :os
      t.text :terms_of_use
      t.text :privacy_policy
      t.text :whats_new
      t.string :link_to_store
      
      t.timestamps
    end
  end
end
