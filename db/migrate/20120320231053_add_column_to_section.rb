class AddColumnToSection < ActiveRecord::Migration
  def change
    add_column :sections, :hasBigSubsections, :boolean, :default => false

  end
end
