class LinkTableToOrder < ActiveRecord::Migration
  def change
    change_table :orders do |t|
      t.references :table
    end
    add_index :orders, :table_id
  end
end
