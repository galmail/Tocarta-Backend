class RecreateDishVariation < ActiveRecord::Migration
  def up
    drop_table :dish_variations if self.table_exists?("dish_variations")
    create_table :dish_variations do |t|
      t.references :chain
      t.string :name
      t.boolean :active
      t.integer :position
      t.decimal :price
      t.text :description
      t.timestamps
    end
    add_index :dish_variations, :chain_id
    DishVariation.create_translation_table! :name => :string, :description => :text
  end
  
  def down
    DishVariation.drop_translation_table!
  end
end
