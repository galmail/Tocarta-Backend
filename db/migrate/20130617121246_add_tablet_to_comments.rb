class AddTabletToComments < ActiveRecord::Migration
  def up
    change_table :comments do |t|
      t.references :tablet
    end
    add_index :comments, :tablet_id
  end
  
  def down
    remove_column :comments, :tablet_id
  end
end
