class AddSidToFloors < ActiveRecord::Migration
  def change
    add_column :floors, :sid, :string
  end
end
