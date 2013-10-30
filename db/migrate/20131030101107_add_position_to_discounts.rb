class AddPositionToDiscounts < ActiveRecord::Migration
  def change
    add_column :discounts, :position, :integer
  end
end
