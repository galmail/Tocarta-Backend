class User < ActiveRecord::Base
  rolify

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable, :recoverable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :rol

  after_create :make_restaurant_demo

  has_many :chains
  has_many :restaurants
  has_one  :client

  def rol
    @rol || 'user'
  end

  private

  # Create a restaurant and dependencies (chain, section, menu)
  # FIXME: This is not the best place for this
  # TODO: default images must be set in views is they not exist with a helper
  DEF_LOGO     = Rails.root.join('app','assets','images', 'default_restaurant_logo.png')
  DEF_SECTION  = Rails.root.join('app','assets','images', 'default_section.png')
  DEF_DISH     = Rails.root.join('app','assets','images', 'default_dish.png')
  def make_restaurant_demo
    if self.role == 'restaurant' # only for this role

      chain = Chain.create(user_id: self.id, name: "Mi Cadena de Restaurantes #{self.email}", logo: DEF_LOGO, email: self.email)

      restaurant = Restaurant.create(user_id: self.id, chain_id: chain.id, name: 'Mi Restaurante Demo', email: self.email)

      menu = Menu.create(restaurant_id: restaurant.id, name: "Mi Menu", menu_type: 'main')

      section = Section.create(menu_id: menu.id, name: 'Mi Seccion', active: true, photo: DEF_SECTION)

      Dish.create(name: 'principal', photo: DEF_DISH, active: true, rate_me: true, description: 'plato principal', price: 20, chain_id: chain.id, position: 1, section_ids: [section.id])
      Dish.create(name: 'segundo', photo: DEF_DISH, active: true, rate_me: true, description: 'plato principal', price: 15, chain_id: chain.id, position: 1, section_ids: [section.id])
    end
  end

end
