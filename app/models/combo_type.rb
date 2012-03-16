class ComboType < ActiveRecord::Base
  belongs_to :restaurant
	has_many :combos
	has_many :order_items
	translates :name, :description, :fallbacks_for_empty_translations => true
	attr_accessible :active, :position, :price, :description
end
