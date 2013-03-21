class Tablet < ActiveRecord::Base
  belongs_to :table
	has_many :orders
	attr_accessible :name, :active, :activated, :access_key, :display_size, :device_brand, :device_name, :device_os, :last_menu_sync, :alive, :table_id
	after_initialize :init
	
	### Validations ###
	
	validates :access_key, :table_id, :presence => true
	validates :access_key, :uniqueness => true
	
	def init
	  self.access_key ||= (0...8).map{65.+(rand(25)).chr}.join
	end
	
	def send_update_notification
	  Pusher["tocarta_lk_#{self.access_key}_channel"].trigger('update',{})
	end
	
end
