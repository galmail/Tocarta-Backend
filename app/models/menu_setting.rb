class MenuSetting < ActiveRecord::Base
  belongs_to :menu
	attr_accessible :name, :active, :priority, :trigger_activation, :last_time_changed, :menu_id
	attr_accessible :from_day, :to_day, :from_time, :to_time
	
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
