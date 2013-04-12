class LinkSkinToUser < ActiveRecord::Migration
  def change
    change_table :skins do |t|
      t.references :user
    end
    add_index :skins, :user_id
  end
end
