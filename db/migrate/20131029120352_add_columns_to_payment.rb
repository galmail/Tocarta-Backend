class AddColumnsToPayment < ActiveRecord::Migration
  def up
    add_column  :payments, :active, :boolean, :default => true
    add_column  :payments, :key, :string
    Payment.create_translation_table! :name => :string
  end
  
  def down
    remove_column :payments, :active, :key
    Payment.drop_translation_table!
  end
  
end
