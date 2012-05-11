class AddColumnsChainToDishes < ActiveRecord::Migration
  def up
    change_table :dishes do |t|
      t.references :chain
    end
    add_index :dishes, :chain_id
  end
  
  def down
    remove_column :dishes, :chain_id
  end
end
