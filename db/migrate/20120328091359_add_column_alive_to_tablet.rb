class AddColumnAliveToTablet < ActiveRecord::Migration
  def change
    add_column :tablets, :alive, :datetime
  end
end
