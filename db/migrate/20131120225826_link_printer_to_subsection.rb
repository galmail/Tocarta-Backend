class LinkPrinterToSubsection < ActiveRecord::Migration
  def up
    change_table :subsections do |t|
      t.references :printer
    end
    add_index :subsections, :printer_id
  end
  
  def down
    remove_column :subsections, :printer_id
  end
end
