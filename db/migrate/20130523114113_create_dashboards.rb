class CreateDashboards < ActiveRecord::Migration
  def change
    create_table :dashboards do |t|
      t.string :name, :null => false
      t.text :options

      t.timestamps
    end
    add_index :dashboards, :name, :unique => true
  end
end
