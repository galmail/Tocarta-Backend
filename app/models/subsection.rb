class Subsection < ActiveRecord::Base
  belongs_to :section
	has_many :dishes
	has_attached_file :photo,:path => "img/subsections/subsection_:id.:extension"
	translates :name, :fallbacks_for_empty_translations => true
	attr_accessible :active, :position
end
