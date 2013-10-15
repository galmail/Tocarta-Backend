class Payment < ActiveRecord::Base
  include Utils
  before_save :generate_sid
  
  belongs_to  :restaurant
  attr_accessible :name, :sid, :restaurant_id
end