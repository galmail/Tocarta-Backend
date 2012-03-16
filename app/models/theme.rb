class Theme < ActiveRecord::Base
	has_many :menus
	attr_accessible :css, :description
end
