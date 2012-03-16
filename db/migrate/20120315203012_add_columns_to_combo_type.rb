class AddColumnsToComboType < ActiveRecord::Migration
  def change
    add_column :combo_types, :active, :boolean

    add_column :combo_types, :position, :integer

    add_column :combo_types, :price, :decimal

    add_column :combo_types, :description, :text

  end
end
