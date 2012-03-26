class Restaurant < ActiveRecord::Base
  belongs_to :user
  belongs_to :chain
	has_one :restaurant_setting
	has_many :restaurant_activities
	has_many :restaurant_banners
	has_many :menus
	has_many :combos
	has_many :combo_types
	has_many :tables
	has_many :comments
	attr_accessible :name, :manager, :email, :address, :phone, :note, :chain_id, :user_id
end
