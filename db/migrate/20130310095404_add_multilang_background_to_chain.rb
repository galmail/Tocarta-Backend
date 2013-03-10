class AddMultilangBackgroundToChain < ActiveRecord::Migration
  def self.up
    add_column :chains, :i18nbg_file_name, :string
    add_column :chains, :i18nbg_content_type, :string
    add_column :chains, :i18nbg_file_size, :integer
    add_column :chains, :i18nbg_updated_at, :datetime
  end

  def self.down
    remove_column :chains, :i18nbg_file_name
    remove_column :chains, :i18nbg_content_type
    remove_column :chains, :i18nbg_file_size
    remove_column :chains, :i18nbg_updated_at
  end
end
