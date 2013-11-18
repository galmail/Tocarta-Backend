class AddProvisionRestDemoToUsers < ActiveRecord::Migration
  def up
    add_column :users, :provision_demo_restaurant, :boolean
  end
  
  def down
    remove_column :users, :provision_demo_restaurant
  end
end
