class CreateDishTypeAssociations < ActiveRecord::Migration
  def change
    create_table :dish_type_associations do |t|
      t.references :dish_type
      t.references :dish

      t.timestamps
    end
    add_index :dish_type_associations, :dish_type_id
    add_index :dish_type_associations, :dish_id
  end
end
