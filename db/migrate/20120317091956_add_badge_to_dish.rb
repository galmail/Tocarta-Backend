class AddBadgeToDish < ActiveRecord::Migration
  def change
    add_column :dishes, :badge_name, :string

  end
end
