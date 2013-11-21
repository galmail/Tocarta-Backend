class LinkPrinterToMenu < ActiveRecord::Migration
  def up
    change_table :menus do |t|
      t.references :printer
    end
    add_index :menus, :printer_id
  end
  
  def down
    remove_column :menus, :printer_id
  end
end
