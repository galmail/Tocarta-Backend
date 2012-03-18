class MenuSetting < ActiveRecord::Base
  belongs_to :menu
	attr_accessible :name, :active, :priority, :trigger_activation, :last_time_changed, :menu_id
end
