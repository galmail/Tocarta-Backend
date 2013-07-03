# == Schema Information
#
# Table name: tablets
#
#  id             :integer          not null, primary key
#  table_id       :integer
#  name           :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  active         :boolean
#  access_key     :string(255)
#  display_size   :string(255)
#  device_brand   :string(255)
#  device_name    :string(255)
#  device_os      :string(255)
#  last_menu_sync :datetime
#  activated      :boolean          default(FALSE)
#  alive          :datetime
#

require 'net/http'

class Tablet < ActiveRecord::Base
  belongs_to :table
	has_many :orders
	has_many :comments
	attr_accessible :name, :active, :activated, :access_key, :display_size, :device_brand, :device_name, :device_os, :last_menu_sync, :alive, :table_id
	after_initialize :init
	
	### Validations ###
	
	validates :access_key, :table_id, :presence => true
	validates :access_key, :uniqueness => true
	
	def init
	  self.access_key ||= (0...8).map{65.+(rand(25)).chr}.join
	end
	
	def send_update_notification
	  begin
	    Net::HTTP.get(URI.parse("#{ENV['NODE_SERVER']}/proxy?channel=tocarta_lk_#{self.access_key}_channel&action=update"))
	  rescue
	    logger.fatal "Could not send_update_notification to node server!"
	  end
	  # Pusher["tocarta_lk_#{self.access_key}_channel"].trigger('update',{})
	end
	
end
