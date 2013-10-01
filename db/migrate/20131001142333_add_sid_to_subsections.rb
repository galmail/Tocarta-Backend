class AddSidToSubsections < ActiveRecord::Migration
  def change
    add_column :subsections, :sid, :string
  end
end
