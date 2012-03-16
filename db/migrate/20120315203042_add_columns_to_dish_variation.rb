class AddColumnsToDishVariation < ActiveRecord::Migration
  def change
    add_column :dish_variations, :price, :decimal

  end
end
