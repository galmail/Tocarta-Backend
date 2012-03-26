class Dish < ActiveRecord::Base
  belongs_to :combo
  belongs_to :section
  belongs_to :subsection
	has_many :order_items
	has_many :comments
	has_many :dish_variations
	has_many :dish_type_associations
	has_many :dish_types, :through => :dish_type_associations
	has_attached_file(
	 :photo,
	 :path => ":chain_rest_id/img/dishes/:style/dish_:id.:extension",
	 :styles => { :large => TocartaAdmin::Application::IMAGE_LARGE_SIZE, :thumb => TocartaAdmin::Application::IMAGE_THUMBNAIL_SIZE, :mini => TocartaAdmin::Application::IMAGE_MINI_SIZE }
	)
	translates :name, :description, :story, :fallbacks_for_empty_translations => true
	attr_accessible :name, :active, :position, :description, :price, :rating, :reviews, :story, :video, :nutrition_facts, :badge_name, :photo
	attr_accessible :section_id, :subsection_id
	
	def update_rating(comment_rating)
    num_comments = self.comments.length-1           # total number of comments (should filter only those comments that left)
    self.rating ||= 0                               # actual dish rating
    rate = ((num_comments.to_f*self.rating)+comment_rating.to_f)/(num_comments.to_f+1)
    # puts "comment_rating=" + comment_rating.to_s
    # puts "num_comments=" + num_comments.to_s
    # puts "rating=" + rating.to_s
    self.rating = rate
    self.save
  end
	
end
