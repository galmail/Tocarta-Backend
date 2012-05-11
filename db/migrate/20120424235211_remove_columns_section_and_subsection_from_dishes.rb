class RemoveColumnsSectionAndSubsectionFromDishes < ActiveRecord::Migration
  def up
    remove_column :dishes, :section_id
    remove_column :dishes, :subsection_id
  end
  def down
    change_table :dishes do |t|
      t.references :section
      t.references :subsection
    end
    add_index :dishes, :section_id
    add_index :dishes, :subsection_id
  end
end
