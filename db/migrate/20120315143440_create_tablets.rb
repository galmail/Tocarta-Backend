class CreateTablets < ActiveRecord::Migration
  def change
    create_table :tablets do |t|
      t.references :table
      t.string :name

      t.timestamps
    end
    add_index :tablets, :table_id
  end
end
