class AddSidToModifierLists < ActiveRecord::Migration
  def change
    add_column :modifier_lists, :sid, :string
  end
end
