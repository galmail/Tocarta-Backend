class AddSidToDishes < ActiveRecord::Migration
  def change
    add_column :dishes, :sid, :string
  end
end
