class ChangeColumnActiveToSection < ActiveRecord::Migration
  def up
    change_column :sections, :active, :boolean, :default => true
  end

  def down
  end
end
