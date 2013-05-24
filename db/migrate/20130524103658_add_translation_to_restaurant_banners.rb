class AddTranslationToRestaurantBanners < ActiveRecord::Migration
  def up
    RestaurantBanner.create_translation_table! :photo_file_name => :string, :photo_content_type => :string
  end
  
  def down
    RestaurantBanner.drop_translation_table!
  end
  
end
