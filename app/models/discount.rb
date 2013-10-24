class Discount < ActiveRecord::Base
  include Utils
  before_save :generate_sid
  
  belongs_to  :restaurant
  attr_accessible :sid, :name, :note, :dtype, :amount, :restaurant_id
end
