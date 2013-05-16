# == Schema Information
#
# Table name: combo_types
#
#  id            :integer          not null, primary key
#  restaurant_id :integer
#  name          :string(255)
#  active        :boolean
#  position      :integer
#  price         :decimal(, )
#  description   :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class ComboType < ActiveRecord::Base
  belongs_to :restaurant
	has_many :combos
	has_many :order_items
	translates :name, :description, :fallbacks_for_empty_translations => true
	attr_accessible :active, :position, :price, :name, :description, :restaurant_id
end
