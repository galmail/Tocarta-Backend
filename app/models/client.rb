class Client < ActiveRecord::Base
  belongs_to :user
	has_many :orders
	has_many :comments
end
