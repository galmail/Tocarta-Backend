class ChangeDishVariationAssociations < ActiveRecord::Migration
  def up
    
    drop_table :dish_variations if self.table_exists?("dish_variations")
    drop_table :dish_variation_translations if self.table_exists?("dish_variation_translations")
    
    create_table :dish_variations do |t|
      t.references :dish_variation_set
      t.string :name
      t.boolean :active
      t.integer :position
      t.decimal :price
      t.text :description
      t.timestamps
    end
    add_index :dish_variations, :dish_variation_set_id
    DishVariation.create_translation_table! :name => :string, :description => :text    
  end
  
  def down
    DishVariation.drop_translation_table!
  end
end
