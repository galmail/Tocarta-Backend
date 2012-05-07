class AddColumnsDishesPerPageToSections < ActiveRecord::Migration
  def change
    add_column :sections, :dishes_per_page, :integer, :default => 0
  end
end
