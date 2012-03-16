class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.references :restaurant
      t.references :theme
      t.string :name

      t.timestamps
    end
    add_index :menus, :restaurant_id
    add_index :menus, :theme_id
  end
end
