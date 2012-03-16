class AddColumnsToSubsection < ActiveRecord::Migration
  def change
    add_column :subsections, :active, :boolean

    add_column :subsections, :position, :integer

  end
end
