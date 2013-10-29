# == Schema Information
#
# Table name: sections
#
#  id                 :integer          not null, primary key
#  menu_id            :integer
#  name               :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#  active             :boolean          default(TRUE)
#  position           :integer
#  hasBigSubsections  :boolean          default(FALSE)
#  dishes_per_page    :integer          default(0)
#

class Section < ActiveRecord::Base
  include Utils
  before_save :generate_sid
  
  belongs_to :menu
  has_many :discounts
  has_many :dishes, :through => :dish_section_associations, :dependent => :destroy
  has_many :dish_section_associations, :dependent => :destroy
  has_many :subsections, :dependent => :destroy
  
  has_attached_file(
    :photo,
    :path => ":chain_rest_id/img/sections/:style/section_:id.:extension",
    :styles => { :mini => TocartaAdmin::Application::IMAGE_MINI_SIZE, :thumb => TocartaAdmin::Application::IMAGE_THUMBNAIL_SIZE }
  )
  translates :name, :fallbacks_for_empty_translations => true
  attr_accessible :name, :active, :position, :photo, :hasBigSubsections, :dishes_per_page
  attr_accessible :menu_id, :sd_category_id, :sid

  ### Validations ###

  validates :menu_id, :presence => true
  validates_attachment_presence :photo

end
