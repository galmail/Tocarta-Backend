# == Schema Information
#
# Table name: subsections
#
#  id                 :integer          not null, primary key
#  section_id         :integer
#  name               :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#  active             :boolean          default(TRUE)
#  position           :integer
#

class Subsection < ActiveRecord::Base
  include Utils
  before_save :generate_sid
  
  belongs_to  :section
  belongs_to  :printer
  has_many    :discounts
	has_many    :dishes, :through => :dish_subsection_associations
  has_many    :dish_subsection_associations
  
	has_attached_file(
	 :photo,
	 :path => ":chain_rest_id/img/subsections/:style/subsection_:id.:extension",
	 :styles => { :mini => TocartaAdmin::Application::IMAGE_MINI_SIZE, :thumb => TocartaAdmin::Application::IMAGE_THUMBNAIL_SIZE }
	)
	translates :name, :fallbacks_for_empty_translations => true
	attr_accessible :active, :position, :photo, :name, :sid
	attr_accessible :section_id, :printer_id
	
	def complex_sid(parent)
    return "#{self.sid}+#{parent.sid}"
  end
	
end
