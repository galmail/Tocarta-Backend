class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.references :user
      t.string :name

      t.timestamps
    end
    add_index :clients, :user_id
  end
end
