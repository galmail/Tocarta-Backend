class Chain < ActiveRecord::Base
  belongs_to :user
	has_many :restaurants
	has_many :survey_questions
	has_attached_file(
	 :logo,
	 :path => "chain_:id/img/:style/chain_:id.:extension",
	 :styles => { :medium => TocartaAdmin::Application::IMAGE_MEDIUM_SIZE }
	)
	has_attached_file(
   :i18nbg,
   :path => "chain_:id/img/chain_:id_i18nbg.:extension"
  )
  has_attached_file(
   :bg,
   :path => "chain_:id/img/chain_:id_bg.:extension"
  )
  
	attr_accessible :name, :email, :address, :note, :logo, :i18nbg, :bg, :user_id, :restaurant_ids
	validates_attachment_presence :logo
	validates :user_id, :presence => true
	
end
