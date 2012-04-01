class SurveyQuestion < ActiveRecord::Base
  belongs_to :chain
	has_many :comments
	translates :name, :description, :fallbacks_for_empty_translations => true
	attr_accessible :name, :description, :position, :active, :chain_id
end


