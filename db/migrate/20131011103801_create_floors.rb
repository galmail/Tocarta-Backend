class CreateFloors < ActiveRecord::Migration
  def change
    create_table :floors do |t|
      t.references :restaurant
      t.string :name
      t.timestamps
    end
    add_index :floors, :restaurant_id
  end
end
