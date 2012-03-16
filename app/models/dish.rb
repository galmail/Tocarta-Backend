class Dish < ActiveRecord::Base
  belongs_to :combo
  belongs_to :section
  belongs_to :subsection
	has_many :order_items
	has_many :comments
	has_many :dish_variations
	has_many :dish_type_associations
	has_many :dish_types, :through => :dish_type_associations
	has_attached_file :photo, :path => "img/dishes/dish_:id.:extension"
	translates :name, :description, :story, :fallbacks_for_empty_translations => true
	attr_accessible :active, :position, :description, :price, :rating, :reviews, :story, :video, :nutrition_facts
end
