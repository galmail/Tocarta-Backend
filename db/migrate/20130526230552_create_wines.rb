class CreateWines < ActiveRecord::Migration
  def up
    drop_table :wines if self.table_exists?("wines")
    create_table :wines do |t|
      t.references  :chain
      t.references  :restaurant
      t.references  :wine_detail
      t.decimal     :price
      t.string      :container
      t.boolean     :active, :default => true
      t.timestamps
    end
    add_index :wines, :chain_id
    add_index :wines, :restaurant_id
    Wine.create_translation_table!(:container => :string)
  end
  
  def down
    Wine.drop_translation_table!
  end
end
