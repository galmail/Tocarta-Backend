# == Schema Information
#
# Table name: ingredients
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Ingredient < ActiveRecord::Base
  translates :name, :fallbacks_for_empty_translations => true
  attr_accessible :name
  has_and_belongs_to_many :dishes
end
