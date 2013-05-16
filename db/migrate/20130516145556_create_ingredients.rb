class CreateIngredients < ActiveRecord::Migration
  def up
    create_table :ingredients do |t|
      t.string :name
      t.timestamps
    end
    Ingredient.create_translation_table! :name => :string
  end
  def down
    drop_table :ingredients
    Ingredient.drop_translation_table!
  end
end
