class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, #:registerable,
         :rememberable, :trackable, :validatable #, :recoverable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :role

  after_create :make_restaurant

  require 'open-uri'

  # FIXME: this must be a constant
  def role_enum
    ['admin', 'restaurant', 'distributor']
  end
  
	has_one :chain
	has_one :restaurant
	has_one :client

  def make_restaurant
    if self.role == 'restaurant'
      #create chain, restaurant and two dishes for demo
      chain = Chain.create(user_id: self.id, name: "Mi Cadena de Restaurantes #{self.email}", logo: File.open("#{Rails.root}/app/assets/images/restaurant-logo.jpg"), email: self.email)
      Restaurant.create(user_id: self.id, chain_id: chain.id, name: 'Mi Restaurante Demo', email: self.email)
      Dish.create(name: 'principal', photo: File.open("#{Rails.root}/app/assets/images/dish-1.jpg"), active: true, rate_me: true, description: 'plato principal', price: 20, chain_id: chain.id, position: 1)
      Dish.create(name: 'segundo', photo: File.open("#{Rails.root}/app/assets/images/dish-2.jpg"), active: true, rate_me: true, description: 'plato principal', price: 15, chain_id: chain.id, position: 1)
    end
  end
  
end
