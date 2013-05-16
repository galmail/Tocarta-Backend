class CreateFoodTags < ActiveRecord::Migration
  def change
    create_table :food_tags do |t|
      t.string :name

      t.timestamps
    end
  end
end
