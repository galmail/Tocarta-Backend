class AddSidToModifiers < ActiveRecord::Migration
  def change
    add_column :modifiers, :sid, :string
  end
end
