class RestaurantActivity < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :table
  belongs_to :order
	attr_accessible :ack
	
	def table_number
	  self.table.number unless self.table.nil?
	end
	
	def date
    ChronicDuration.output((Time.now.round - self.created_at.round).to_i, :format => :short)
  end
	
end
