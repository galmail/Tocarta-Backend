class CreateDashboards < ActiveRecord::Migration
  def up
    if !self.table_exists?("dashboards")
      create_table :dashboards do |t|
        t.string :name, :null => false
        t.text :options
  
        t.timestamps
      end
      add_index :dashboards, :name, :unique => true
    end
  end
  
  def down
    drop_table :dashboards if self.table_exists?("dashboards")
  end
end
