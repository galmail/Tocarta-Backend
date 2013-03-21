class AddColumnsToSkin < ActiveRecord::Migration
  def self.up
    add_column :skins, :description, :text
    add_column :skins, :stylesheet_file_name, :string
    add_column :skins, :stylesheet_content_type, :string
    add_column :skins, :stylesheet_file_size, :integer
    add_column :skins, :stylesheet_updated_at, :datetime
  end

  def self.down
    remove_column :skins, :description
    remove_column :skins, :stylesheet_file_name
    remove_column :skins, :stylesheet_content_type
    remove_column :skins, :stylesheet_file_size
    remove_column :skins, :stylesheet_updated_at
  end
end
