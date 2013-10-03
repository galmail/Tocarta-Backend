class CreateModifierListSets < ActiveRecord::Migration
  def change
    create_table :modifier_list_sets do |t|

      t.timestamps
    end
  end
end
