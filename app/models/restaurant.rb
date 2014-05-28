# == Schema Information
#
# Table name: restaurants
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  chain_id   :integer
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  manager    :string(255)
#  email      :string(255)
#  address    :string(255)
#  phone      :string(255)
#  note       :text
#

class Restaurant < ActiveRecord::Base
  belongs_to :user
  belongs_to :chain
	has_one :restaurant_setting
	has_many :restaurant_activities
	has_many :restaurant_banners
	has_many :menus
	has_many :wines
	has_many :combos
	has_many :combo_types
	has_many :tables
	has_many :comments
	attr_accessible :name, :manager, :email, :address, :phone, :note, :chain_id, :user_id
	validates :chain_id, :presence => true
	
	def tablets
	  self.tables.collect { |table| table.tablets }.flatten.select { |tablet| tablet.active }
	end
	
	def active_menus
	  self.menus.sort_by! { |menu| menu.position }
	  self.menus.select { |menu| menu.activated }
	end
	
end
