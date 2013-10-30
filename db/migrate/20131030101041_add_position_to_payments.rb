class AddPositionToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :position, :integer
  end
end
