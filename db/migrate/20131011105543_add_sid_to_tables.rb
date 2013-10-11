class AddSidToTables < ActiveRecord::Migration
  def change
    add_column :tables, :sid, :string
  end
end
