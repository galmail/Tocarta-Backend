class RemovePriorityFromMenuSettings < ActiveRecord::Migration
  def change
    remove_column :menu_settings, :priority
  end
end
