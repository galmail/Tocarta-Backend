class CreateDishVariationSets < ActiveRecord::Migration
  def change
    create_table :dish_variation_sets do |t|
      t.references :chain
      t.string :name
      t.timestamps
    end
    add_index :dish_variation_sets, :chain_id
  end
end
