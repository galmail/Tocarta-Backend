class AddTaxIncludedToDishes < ActiveRecord::Migration
  def change
    add_column :dishes, :tax_included, :boolean, :default => true
  end
end
