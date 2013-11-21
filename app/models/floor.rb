class Floor < ActiveRecord::Base
  include Utils
  before_save :generate_sid
  
  belongs_to  :restaurant
  belongs_to  :printer
  has_many    :tables, :dependent => :destroy
  
  attr_accessible :name, :sid, :restaurant_id, :printer_id
  
end
