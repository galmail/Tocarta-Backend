# == Schema Information
#
# Table name: restaurant_banners
#
#  id                 :integer          not null, primary key
#  restaurant_id      :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#  name               :string(255)
#  position           :integer
#  active             :boolean          default(TRUE)
#

class RestaurantBanner < ActiveRecord::Base
  belongs_to :restaurant
  
  has_attached_file(
   :photo,
   :default_url => '/default_images/rest_demo_banner1.jpg',
   :path => ":locale/:chain_rest_id/img/banners/:style/banner_:id.:extension",
   :styles => { :banner => TocartaAdmin::Application::IMAGE_BANNER_SIZE }
  )
  
  translates :photo_file_name, :photo_content_type
  
  attr_accessible :name, :position, :active, :photo
  attr_accessible :restaurant_id
  
end
