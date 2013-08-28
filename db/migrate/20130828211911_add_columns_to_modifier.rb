class AddColumnsToModifier < ActiveRecord::Migration
  def up
    add_column(:modifiers, :description, :string)
    add_column(:modifiers, :price, :decimal)
  end

  def down
    remove_column(:modifiers, :description)
    remove_column(:modifiers, :price)
  end
end
