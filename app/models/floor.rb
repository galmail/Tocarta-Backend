class Floor < ActiveRecord::Base
  belongs_to  :restaurant
  has_many    :tables
  
  attr_accessible :name, :sid, :restaurant_id
  
end
