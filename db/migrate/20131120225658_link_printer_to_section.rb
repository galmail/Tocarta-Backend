class LinkPrinterToSection < ActiveRecord::Migration
  def up
    change_table :sections do |t|
      t.references :printer
    end
    add_index :sections, :printer_id
  end
  
  def down
    remove_column :sections, :printer_id
  end
end
