class CreateSkins < ActiveRecord::Migration
  def change
    create_table :skins do |t|
      t.references :theme
      t.string :name

      t.timestamps
    end
    add_index :skins, :theme_id
  end
end
