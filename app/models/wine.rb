class Wine < ActiveRecord::Base
  belongs_to  :chain
  belongs_to  :restaurant
  belongs_to  :wine_detail
  
  attr_accessible :chain_id, :restaurant_id, :wine_detail_id, :price, :container, :active
  translates :container, :fallbacks_for_empty_translations => true
  
end
