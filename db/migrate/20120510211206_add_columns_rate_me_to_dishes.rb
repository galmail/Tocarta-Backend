class AddColumnsRateMeToDishes < ActiveRecord::Migration
  def change
    add_column :dishes, :rate_me, :boolean, :default => true

  end
end
