class AddSelectedModifierToModifierList < ActiveRecord::Migration
  def change
    change_table :modifier_lists do |t|
      t.references :modifier
    end
    add_index :modifier_lists, :modifier_id
  end
end
