# == Schema Information
#
# Table name: order_items
#
#  id            :integer          not null, primary key
#  order_id      :integer
#  dish_id       :integer
#  combo_id      :integer
#  combo_type_id :integer
#  name          :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  quantity      :integer
#  note          :string(255)
#

class OrderItem < ActiveRecord::Base
  include MongohqLogger
  belongs_to :order
  belongs_to :dish
  belongs_to :combo
  belongs_to :combo_type
	attr_accessible :quantity, :note, :name
	
	after_save :logme
	
end
