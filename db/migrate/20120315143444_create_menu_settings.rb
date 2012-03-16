class CreateMenuSettings < ActiveRecord::Migration
  def change
    create_table :menu_settings do |t|
      t.references :menu
      t.string :name

      t.timestamps
    end
    add_index :menu_settings, :menu_id
  end
end
