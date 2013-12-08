class Waiter < ActiveRecord::Base
  belongs_to  :restaurant
  belongs_to  :waiter_app
  
  attr_accessible :name, :username, :password, :email, :role, :birthday, :mobile_number, :device_id, :key, :active
  attr_accessible :sd_userid, :sd_employeeid
  attr_accessible :restaurant_id, :waiter_app_id
  
  #validates :username, :presence => true, :uniqueness => true
  #validates :username, :password, :length => { :minimum => 4 }
  validates :key, :presence => true, :uniqueness => true
  
  def role_enum
    return ['waiter','manager']
  end
  
end
