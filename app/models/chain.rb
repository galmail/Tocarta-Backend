class Chain < ActiveRecord::Base
  belongs_to :user
	has_many :restaurants
	has_many :survey_questions
	has_attached_file(
	 :logo,
	 :path => "chain_:id/img/:style/chain_:id.:extension",
	 :styles => { :medium => TocartaAdmin::Application::IMAGE_MEDIUM_SIZE }
	)
	attr_accessible :name, :email, :address, :note, :logo, :user_id, :restaurant_ids
	validates_attachment_presence :logo
	
end
