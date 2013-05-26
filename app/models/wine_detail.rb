class WineDetail < ActiveRecord::Base
  belongs_to  :user
  has_many    :wines
  attr_accessible :user_id, :name, :description, :wine_type, :wine_cellar, :vintage, :country, :region, :grape_type, :pairing, :ideal_temperature, :color, :flavor, :aroma, :score
  translates :name, :description, :wine_type, :country, :region, :grape_type, :pairing, :ideal_temperature, :color, :flavor, :aroma, :fallbacks_for_empty_translations => true
end
