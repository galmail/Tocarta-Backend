class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.references :user
      t.references :chain
      t.string :name

      t.timestamps
    end
    add_index :restaurants, :user_id
    add_index :restaurants, :chain_id
  end
end
