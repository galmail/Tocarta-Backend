class CreateTables < ActiveRecord::Migration
  def change
    create_table :tables do |t|
      t.references :restaurant
      t.string :name

      t.timestamps
    end
    add_index :tables, :restaurant_id
  end
end
