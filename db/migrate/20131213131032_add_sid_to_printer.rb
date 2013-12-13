class AddSidToPrinter < ActiveRecord::Migration
  def change
    add_column :printers, :sid, :string
  end
end
