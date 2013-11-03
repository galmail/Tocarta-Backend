# == Schema Information
#
# Table name: menu_settings
#
#  id                 :integer          not null, primary key
#  menu_id            :integer
#  name               :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  active             :boolean
#  trigger_activation :datetime
#  last_time_changed  :datetime
#  from_day           :string(255)
#  to_day             :string(255)
#  from_time          :time
#  to_time            :time
#

class MenuSetting < ActiveRecord::Base
  belongs_to :menu
	attr_accessible :name, :active, :trigger_activation, :last_time_changed, :menu_id
	attr_accessible :from_day, :to_day, :from_time, :to_time
	
	### Validations ###
  
  validates :menu_id, :presence => true
	
	def from_day_enum
	  Date::DAYNAMES
	end
	
	def to_day_enum
    Date::DAYNAMES
  end
	
	def from_day_num
	  Date::DAYNAMES.index(self.from_day)
	end
	
	def to_day_num
    Date::DAYNAMES.index(self.to_day)
  end
	
end
