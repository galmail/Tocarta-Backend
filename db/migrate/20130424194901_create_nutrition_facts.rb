class CreateNutritionFacts < ActiveRecord::Migration
  def change
    create_table :nutrition_facts do |t|
      t.references :dish
      t.integer :calories
      t.integer :fats
      t.integer :carbs
      t.integer :proteins
      t.integer :cholesterol
      t.timestamps
    end
  end
end
