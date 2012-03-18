class AddMoreInfoToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :total, :decimal

    add_column :orders, :language, :string

  end
end
