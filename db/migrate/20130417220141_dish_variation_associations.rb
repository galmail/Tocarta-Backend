class DishVariationAssociations < ActiveRecord::Migration
  def change
    create_table :dish_variation_associations do |t|
      t.references :dish_variation
      t.references :dish

      t.timestamps
    end
    add_index :dish_variation_associations, :dish_variation_id
    add_index :dish_variation_associations, :dish_id
  end
end
