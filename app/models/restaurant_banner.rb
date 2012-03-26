class RestaurantBanner < ActiveRecord::Base
  belongs_to :restaurant
  
  has_attached_file(
   :photo,
   :path => ":chain_rest_id/img/banners/:style/banner_:id.:extension",
   :styles => { :banner => TocartaAdmin::Application::IMAGE_BANNER_SIZE }
  )
  
  attr_accessible :name, :position, :active, :photo
  attr_accessible :restaurant_id
  
end
