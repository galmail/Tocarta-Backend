class Payment < ActiveRecord::Base
  include Utils
  before_save :generate_sid
  
  belongs_to  :restaurant
  attr_accessible :name, :sid, :active, :key, :restaurant_id
  
  translates :name, :fallbacks_for_empty_translations => true
  
end
