class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.references :menu
      t.string :name

      t.timestamps
    end
    add_index :sections, :menu_id
  end
end
