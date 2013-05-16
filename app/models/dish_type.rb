# == Schema Information
#
# Table name: dish_types
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  icon_file_name    :string(255)
#  icon_content_type :string(255)
#  icon_file_size    :integer
#  icon_updated_at   :datetime
#  position          :integer
#  dish_class        :string(255)
#  description       :string(255)
#

class DishType < ActiveRecord::Base
	has_many :dish_type_associations
	has_many :dishes, :through => :dish_type_associations
	
	has_attached_file(
   :icon,
   :path => "common/img/dish_types/:style/dish_type_:id.:extension",
   :styles => { :big_icon => TocartaAdmin::Application::BIG_ICON_SIZE, :small_icon => TocartaAdmin::Application::SMALL_ICON_SIZE }
  )
	attr_accessible :name, :position, :icon, :description
	translates :description, :fallbacks_for_empty_translations => true
	
end
