class AddAttachmentIconToDishType < ActiveRecord::Migration
  def self.up
    add_column :dish_types, :icon_file_name, :string
    add_column :dish_types, :icon_content_type, :string
    add_column :dish_types, :icon_file_size, :integer
    add_column :dish_types, :icon_updated_at, :datetime
  end

  def self.down
    remove_column :dish_types, :icon_file_name
    remove_column :dish_types, :icon_content_type
    remove_column :dish_types, :icon_file_size
    remove_column :dish_types, :icon_updated_at
  end
end
