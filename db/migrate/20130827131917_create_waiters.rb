class CreateWaiters < ActiveRecord::Migration
  def change
    create_table :waiters do |t|
      t.references :restaurant
      t.string :username
      t.string :password
      t.string :email
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.date   :birthday
      t.string :mobile_number
      t.string :device_id
      
      t.timestamps
    end
    add_index :waiters, :restaurant_id
  end
end
