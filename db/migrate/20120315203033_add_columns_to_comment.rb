class AddColumnsToComment < ActiveRecord::Migration
  def change
    add_column :comments, :description, :text

    add_column :comments, :rating, :integer

    add_column :comments, :approved, :boolean

  end
end
