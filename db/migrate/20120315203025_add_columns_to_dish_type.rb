class AddColumnsToDishType < ActiveRecord::Migration
  def change
    add_column :dish_types, :position, :integer

    add_column :dish_types, :dish_class, :string

  end
end