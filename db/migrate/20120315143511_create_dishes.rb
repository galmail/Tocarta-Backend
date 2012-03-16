class CreateDishes < ActiveRecord::Migration
  def change
    create_table :dishes do |t|
      t.references :combo
      t.references :section
      t.references :subsection
      t.string :name

      t.timestamps
    end
    
    add_index :dishes, :combo_id
    add_index :dishes, :section_id
    add_index :dishes, :subsection_id
  end
end
