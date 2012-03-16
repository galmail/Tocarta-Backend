class Tablet < ActiveRecord::Base
  belongs_to :table
	has_many :orders
	attr_accessible :active, :access_key, :display_size, :device_brand, :device_name, :device_os, :last_menu_sync
end
