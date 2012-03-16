class Section < ActiveRecord::Base
  belongs_to :menu
	has_many :dishes
	has_many :subsections
	has_attached_file :photo,:path => "img/sections/section_:id.:extension"
	translates :name, :fallbacks_for_empty_translations => true
	attr_accessible :active, :position
end
