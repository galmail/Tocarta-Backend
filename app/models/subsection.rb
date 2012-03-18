class Subsection < ActiveRecord::Base
  belongs_to :section
	has_many :dishes
	has_attached_file :photo, :path => "img/subsections/:style/subsection_:id.:extension", :styles => { :medium => "300x300>", :thumb => "100x100>" }
	translates :name, :fallbacks_for_empty_translations => true
	attr_accessible :active, :position, :photo, :name
	attr_accessible :section_id
end
