class AddSidToSections < ActiveRecord::Migration
  def change
    add_column :sections, :sid, :string
  end
end
