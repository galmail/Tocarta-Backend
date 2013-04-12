class SurveyQuestion < ActiveRecord::Base
  belongs_to :chain
	has_many :comments
	translates :name, :description, :fallbacks_for_empty_translations => true
	attr_accessible :name, :description, :position, :active, :yes_no_type, :chain_id
end


