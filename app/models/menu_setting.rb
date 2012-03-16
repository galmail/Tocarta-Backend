class MenuSetting < ActiveRecord::Base
  belongs_to :menu
	attr_accessible :active, :priority, :trigger_activation, :last_time_changed
end
