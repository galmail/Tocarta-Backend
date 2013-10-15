class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.references  :restaurant
      t.string      :name
      t.string      :key
      t.text        :value
      t.boolean     :is_image, :default => false
      
      t.timestamps
    end
    add_index :resources, :restaurant_id
  end
end
