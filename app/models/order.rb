class Order < ActiveRecord::Base
  belongs_to :tablet
  belongs_to :table
  belongs_to :client
	has_many :order_items
	has_many :restaurant_activities
	attr_accessible :name, :note, :total, :language, :table_id, :tablet_id, :client_id, :order_items
end
