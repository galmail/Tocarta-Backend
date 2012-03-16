class AddColumnsToChain < ActiveRecord::Migration
  def change
    add_column :chains, :email, :string

    add_column :chains, :address, :string

    add_column :chains, :note, :text

  end
end
