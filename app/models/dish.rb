class Dish < ActiveRecord::Base
  before_save :associate_chain
  # FIXME comment these lines after migration
  # belongs_to :section
  # belongs_to :subsection
  # FIXME uncomment these lines after migration
  has_many :combos, :through => :dish_combo_associations
  has_many :dish_combo_associations
  
  
  
  
  has_many :sections, :through => :dish_section_associations
  has_many :dish_section_associations
  has_many :subsections, :through => :dish_subsection_associations
  has_many :dish_subsection_associations
	has_many :order_items
	has_many :comments
	has_many :dish_variations
	has_many :dish_type_associations
	has_many :dish_types, :through => :dish_type_associations
	belongs_to :chain
	has_attached_file(
	 :photo,
	 :path => ":chain_rest_id/img/dishes/:style/dish_:id.:extension",
	 :styles => { :large => TocartaAdmin::Application::IMAGE_LARGE_SIZE, :thumb => TocartaAdmin::Application::IMAGE_THUMBNAIL_SIZE, :mini => TocartaAdmin::Application::IMAGE_MINI_SIZE }
	)
	translates :name, :description, :story, :short_title, :fallbacks_for_empty_translations => true
	attr_accessible :name, :active, :position, :description, :price, :rating, :reviews, :story, :video, :nutrition_facts, :short_title, :badge_name, :photo, :rate_me
	attr_accessible :section_ids, :subsection_ids, :dish_type_ids
	
	### Validations ###
  
  validates :name, :price, :presence => true
  validates_attachment_presence :photo
  validates :badge_name, :length => { :maximum => 11 }
  validate :validate_min_sections
  
	def update_rating(comment_rating)
    num_comments = self.comments.length-1           # total number of comments (should filter only those comments that left)
    self.rating ||= 0                               # actual dish rating
    rate = ((num_comments.to_f*self.rating)+comment_rating.to_f)/(num_comments.to_f+1)
    self.rating = rate
    self.save
  end
  
  def associate_chain
    self.chain = self.sections.first.menu.restaurant.chain
  end
  
  def validate_min_sections
    errors.add(:sections, "at least one section must be selected") if sections.length < 1
  end
	
end
