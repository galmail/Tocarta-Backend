class AddColumnsToTheme < ActiveRecord::Migration
  def change
    add_column :themes, :css, :string

    add_column :themes, :description, :text

  end
end
