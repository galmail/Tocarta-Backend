class CreateDishSubsectionAssociations < ActiveRecord::Migration
  def change
    create_table :dish_subsection_associations do |t|
      t.references :dish
      t.references :subsection

      t.timestamps
    end
    add_index :dish_subsection_associations, :dish_id
    add_index :dish_subsection_associations, :subsection_id
  end
end
