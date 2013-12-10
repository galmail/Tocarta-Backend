# == Schema Information
#
# Table name: tables
#
#  id            :integer          not null, primary key
#  restaurant_id :integer
#  name          :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  number        :integer
#  status        :string(255)
#  dinners       :integer
#  language      :string(255)
#

class Table < ActiveRecord::Base
  include Utils
  before_save :generate_sid
  after_save  :setup_name
  
  belongs_to :restaurant
  belongs_to :floor
	has_many :tablets
	has_many :orders
	has_many :restaurant_activities
	attr_accessible :name, :sid, :number, :status, :dinners, :language, :restaurant_id, :floor_id
	
	### Validations ###
  
  validates :restaurant_id, :number, :presence => true
  validates :number, :uniqueness => { :scope => [:restaurant_id, :floor_id] }
  
  def setup_name
    if self.name.nil?
      self.name = "Mesa #{self.number}"
      self.save
    end
  end
	
end
