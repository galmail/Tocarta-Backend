class LinkMenuToSkin < ActiveRecord::Migration
  def change
    change_table :menus do |t|
      t.references :skin
    end
    add_index :menus, :skin_id
  end
end
