class AddColumnsToDish < ActiveRecord::Migration
  def change
    add_column :dishes, :active, :boolean

    add_column :dishes, :position, :integer

    add_column :dishes, :description, :text

    add_column :dishes, :price, :decimal

    add_column :dishes, :rating, :integer

    add_column :dishes, :reviews, :integer

    add_column :dishes, :story, :text

    add_column :dishes, :video, :string

    add_column :dishes, :nutrition_facts, :string

  end
end
