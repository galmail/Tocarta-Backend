# == Schema Information
#
# Table name: themes
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  css         :string(255)
#  description :text
#

class Theme < ActiveRecord::Base
	has_many :menus
	has_many :skins
	
	attr_accessible :name, :description
end
