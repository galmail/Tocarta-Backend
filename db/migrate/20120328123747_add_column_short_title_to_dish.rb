class AddColumnShortTitleToDish < ActiveRecord::Migration
  def change
    add_column :dishes, :short_title, :string

  end
end
