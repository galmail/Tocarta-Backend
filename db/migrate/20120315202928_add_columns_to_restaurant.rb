class AddColumnsToRestaurant < ActiveRecord::Migration
  def change
    add_column :restaurants, :manager, :string

    add_column :restaurants, :email, :string

    add_column :restaurants, :address, :string

    add_column :restaurants, :phone, :string

    add_column :restaurants, :note, :text

  end
end
