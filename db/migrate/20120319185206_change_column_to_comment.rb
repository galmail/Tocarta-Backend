class ChangeColumnToComment < ActiveRecord::Migration
  def up
    change_column :comments, :approved, :boolean, :default => true
  end

  def down
    change_column :comments, :approved
  end
end
