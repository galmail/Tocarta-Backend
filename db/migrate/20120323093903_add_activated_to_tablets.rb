class AddActivatedToTablets < ActiveRecord::Migration
  def change
    add_column :tablets, :activated, :boolean, :default => false

  end
end
