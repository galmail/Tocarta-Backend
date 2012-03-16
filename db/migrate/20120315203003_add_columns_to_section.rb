class AddColumnsToSection < ActiveRecord::Migration
  def change
    add_column :sections, :active, :boolean

    add_column :sections, :position, :integer

  end
end
