class CreatePrinters < ActiveRecord::Migration
  def change
    create_table :printers do |t|
      t.references  :restaurant
      t.string      :name
      t.string      :model
      t.string      :ip_and_port
      t.integer     :number
      t.boolean     :primary_backup_printer, :default => false
      t.boolean     :secondary_backup_printer, :default => false
    end
    add_index :printers, :restaurant_id
  end
end
