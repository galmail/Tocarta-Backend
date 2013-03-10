class AddBackgroundToChain < ActiveRecord::Migration
  def self.up
    add_column :chains, :bg_file_name, :string
    add_column :chains, :bg_content_type, :string
    add_column :chains, :bg_file_size, :integer
    add_column :chains, :bg_updated_at, :datetime
  end

  def self.down
    remove_column :chains, :bg_file_name
    remove_column :chains, :bg_content_type
    remove_column :chains, :bg_file_size
    remove_column :chains, :bg_updated_at
  end
end
