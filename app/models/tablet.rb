class Tablet < ActiveRecord::Base
  belongs_to :table
	has_many :orders
	attr_accessible :name, :active, :activated, :access_key, :display_size, :device_brand, :device_name, :device_os, :last_menu_sync, :alive, :table_id
end
