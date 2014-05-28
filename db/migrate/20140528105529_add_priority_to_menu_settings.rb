class AddPriorityToMenuSettings < ActiveRecord::Migration
  
  def up
    unless column_exists? :menu_settings, :priority
      add_column :menu_settings, :priority, :integer
    end
  end
  
  def down
    remove_column :menu_settings, :priority
  end
  
end
