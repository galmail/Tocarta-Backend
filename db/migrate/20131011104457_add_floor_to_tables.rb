class AddFloorToTables < ActiveRecord::Migration
  def change
    change_table :tables do |t|
      t.references :floor
    end
    add_index :tables, :floor_id
  end
end
