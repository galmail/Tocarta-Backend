class Theme < ActiveRecord::Base
	has_many :menus
	has_many :skins
	
	attr_accessible :name, :description
end
