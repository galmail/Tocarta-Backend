class AddTranslationToMenus < ActiveRecord::Migration
  def up
    Menu.create_translation_table! :name => :string
  end
  
  def down
    Menu.drop_translation_table!
  end
end
