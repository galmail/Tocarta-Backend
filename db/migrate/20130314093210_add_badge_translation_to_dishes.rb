class AddBadgeTranslationToDishes < ActiveRecord::Migration
  def change
    add_column :dish_translations, :badge_name, :string
  end
end
