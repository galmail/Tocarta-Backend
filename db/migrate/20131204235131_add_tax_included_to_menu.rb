class AddTaxIncludedToMenu < ActiveRecord::Migration
  def change
    add_column :menus, :tax_included, :boolean, :default => true
  end
end
