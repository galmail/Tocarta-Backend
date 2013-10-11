class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.references :restaurant
      t.string :name
      t.string :sid
      t.timestamps
    end
    add_index :payments, :restaurant_id
  end
end
