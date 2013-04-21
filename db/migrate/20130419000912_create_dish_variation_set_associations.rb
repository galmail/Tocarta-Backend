class CreateDishVariationSetAssociations < ActiveRecord::Migration
  def up
    drop_table :dish_variation_associations if self.table_exists?("dish_variation_associations")
    
    create_table :dish_variation_set_associations do |t|
      t.references :dish_variation_set
      t.references :dish
      t.timestamps
    end
    add_index :dish_variation_set_associations, :dish_variation_set_id
    add_index :dish_variation_set_associations, :dish_id
  end
  
  def down

  end
end
