class CreateChains < ActiveRecord::Migration
  def change
    create_table :chains do |t|
      t.references :user
      t.string :name

      t.timestamps
    end
    add_index :chains, :user_id
  end
end
