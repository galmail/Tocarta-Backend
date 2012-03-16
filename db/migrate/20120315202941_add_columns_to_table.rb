class AddColumnsToTable < ActiveRecord::Migration
  def change
    add_column :tables, :number, :integer

    add_column :tables, :status, :string

  end
end
