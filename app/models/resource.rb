class Resource < ActiveRecord::Base
  belongs_to  :restaurant
  attr_accessible :name, :is_image, :key, :value, :restaurant_id
end
