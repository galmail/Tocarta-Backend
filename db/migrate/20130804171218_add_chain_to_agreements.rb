class AddChainToAgreements < ActiveRecord::Migration
  def up
    change_table :agreements do |t|
      t.references :chain
    end
    add_index :agreements, :chain_id
  end
  
  def down
    remove_column :agreements, :chain_id
  end
end
