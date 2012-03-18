class Chain < ActiveRecord::Base
  belongs_to :user
	has_many :restaurants
	has_many :survey_questions
	has_attached_file :logo, :path => "img/chains/:style/chain_:id.:extension", :styles => { :medium => "300x300>", :thumb => "100x100>" }
	attr_accessible :email, :address, :note, :logo
end
