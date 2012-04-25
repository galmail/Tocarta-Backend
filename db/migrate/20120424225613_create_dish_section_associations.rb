class CreateDishSectionAssociations < ActiveRecord::Migration
  def change
    create_table :dish_section_associations do |t|
      t.references :dish
      t.references :section

      t.timestamps
    end
    add_index :dish_section_associations, :dish_id
    add_index :dish_section_associations, :section_id
  end
end
