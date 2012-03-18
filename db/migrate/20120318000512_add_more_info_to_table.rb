class AddMoreInfoToTable < ActiveRecord::Migration
  def change
    add_column :tables, :dinners, :integer
    add_column :tables, :language, :string
  end
end
