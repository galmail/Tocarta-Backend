class CreateDiscounts < ActiveRecord::Migration
  def change
    create_table :discounts do |t|
      t.references :restaurant
      t.string  :sid
      t.string  :name
      t.string  :note
      t.string  :dtype
      t.decimal :amount
      
      t.timestamps
    end
    add_index :discounts, :restaurant_id
  end
end
