class AddTranslationToDishes < ActiveRecord::Migration
  def change
    add_column :dish_translations, :short_title, :string
  end
end
