# == Schema Information
#
# Table name: restaurant_activities
#
#  id            :integer          not null, primary key
#  restaurant_id :integer
#  table_id      :integer
#  order_id      :integer
#  name          :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  ack           :datetime
#

class RestaurantActivity < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :table
  belongs_to :order
	attr_accessible :ack, :name
	
	def table_number
	  self.table.number unless self.table.nil?
	end
	
	def date
    ChronicDuration.output((Time.now.round - self.created_at.round).to_i, :format => :short)
  end
	
end
