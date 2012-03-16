class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :tablet
      t.references :client
      t.string :name

      t.timestamps
    end
    add_index :orders, :tablet_id
    add_index :orders, :client_id
  end
end
