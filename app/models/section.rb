class Section < ActiveRecord::Base
  belongs_to :menu
	has_many :dishes
	has_many :subsections
	has_attached_file :photo, :path => "img/sections/:style/section_:id.:extension", :styles => { :thumb => "100x100>" }
	translates :name, :fallbacks_for_empty_translations => true
	attr_accessible :name, :active, :position, :photo
	attr_accessible :menu_id
end
