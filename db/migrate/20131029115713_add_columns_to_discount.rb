class AddColumnsToDiscount < ActiveRecord::Migration
  def up
    add_column   :discounts, :active, :boolean, :default => true
    change_table :discounts do |t|
      t.references :menu
      t.references :section
      t.references :subsection
      t.references :dish
    end
    add_index :discounts, :menu_id
    add_index :discounts, :section_id
    add_index :discounts, :subsection_id
    add_index :discounts, :dish_id
    
    Discount.create_translation_table! :name => :string
  end
  
  def down
    remove_column :discounts, :active
    remove_column :discounts, :menu_id
    remove_column :discounts, :section_id
    remove_column :discounts, :subsection_id
    remove_column :discounts, :dish_id
    
    Discount.drop_translation_table!
  end
end
