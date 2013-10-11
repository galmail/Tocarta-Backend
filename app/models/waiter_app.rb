class WaiterApp < ActiveRecord::Base
  has_many :waiters
  attr_accessible :name, :version, :os, :terms_of_use, :privacy_policy, :whats_new, :link_to_store  
end
