class LinkPrinterToFloor < ActiveRecord::Migration
  def up
    change_table :floors do |t|
      t.references :printer
    end
    add_index :floors, :printer_id
  end
  
  def down
    remove_column :floors, :printer_id
  end
end
