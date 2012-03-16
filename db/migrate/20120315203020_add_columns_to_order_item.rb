class AddColumnsToOrderItem < ActiveRecord::Migration
  def change
    add_column :order_items, :quantity, :integer

    add_column :order_items, :note, :string

  end
end
