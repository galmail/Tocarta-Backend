# == Schema Information
#
# Table name: orders
#
#  id         :integer          not null, primary key
#  tablet_id  :integer
#  client_id  :integer
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  note       :string(255)
#  table_id   :integer
#  total      :decimal(, )
#  language   :string(255)
#

class Order < ActiveRecord::Base
  include MongohqLogger
  belongs_to :tablet
  belongs_to :table
  belongs_to :client
	has_many :order_items
	has_many :restaurant_activities
	attr_accessible :name, :note, :total, :language, :table_id, :tablet_id, :client_id, :order_items
	
	# after_save :logme
	
end
