class ChangeColumnActiveToSubsection < ActiveRecord::Migration
  def up
    change_column :subsections, :active, :boolean, :default => true
  end

  def down
  end
end
