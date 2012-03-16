class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.references :order
      t.references :dish
      t.references :combo
      t.references :combo_type
      t.string :name

      t.timestamps
    end
    add_index :order_items, :order_id
    add_index :order_items, :dish_id
    add_index :order_items, :combo_id
    add_index :order_items, :combo_type_id
  end
end
