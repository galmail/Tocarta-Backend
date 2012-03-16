class Chain < ActiveRecord::Base
  belongs_to :user
	has_many :restaurants
	has_many :survey_questions
	has_attached_file :logo, :path => "img/chains/chain_:id.:extension"
	attr_accessible :email, :address, :note
end
