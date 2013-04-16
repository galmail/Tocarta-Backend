class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, #:registerable,
         :rememberable, :trackable, :validatable #, :recoverable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :role
  
  # FIXME: this must be a constant
  def role_enum
    ['admin', 'restaurant', 'distributor']
  end
  
	has_one :chain
	has_one :restaurant
	has_one :client
  
end
