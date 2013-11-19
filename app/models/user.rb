# encoding: utf-8
# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(128)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  name                   :string(255)
#  surname                :string(255)
#  city                   :string(255)
#  country                :string(255)
#  birthdate              :date
#  twitter                :string(255)
#  url                    :string(255)
#  phone                  :string(255)
#

class User < ActiveRecord::Base
  rolify
  # NOTE: i think this is dangerous, but is neccesary for rails_admin
  attr_accessible :role_ids, :rol

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable, :recoverable , :token_authenticatable
         # , :confirmable
         # :omniauthable, :omniauth_providers => [:facebook]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :provision_demo_restaurant
  attr_accessible :name, :surname, :city, :country, :birthdate, :twitter, :url, :phone
  attr_accessible :connection_log_ids, :authentication_ids

  #after_create :clone_mw_restaurant_demo

  has_many :chains
  has_many :restaurants
  has_one  :client

  has_many :authentications, :dependent => :delete_all
  has_many :connection_logs, :dependent => :destroy

  # If no role is defined, we define user by default
  def rol
    @rol || 'user'
  end

  def apply_omniauth(auth)
    # In previous omniauth, 'user_info' was used in place of 'raw_info'
    self.email = auth['extra']['raw_info']['email']
    # Save token
    authentications.build(:provider => auth['provider'], :uid => auth['uid'], :token => auth['credentials']['token'])
    # FIXME: use the correct role
    self.add_role :user
  end

  def valid_password?(password)
    if super
      return true
    else
      if self.invalid_password_count >= 2
        self.invalid_password_count = 0
        NotificationMailer.invalid_passwords(self).deliver
      else
        self.invalid_password_count += 1
      end
      self.save

      return false
    end
  end
  private

  # Create a restaurant and dependencies (chain, section, menu)
  def make_restaurant_demo
    return false unless self.provision_demo_restaurant
    return false unless self.has_role? :restaurant or self.has_role? :distributor
    
    chain = Chain.create(user_id: self.id, name: "Cadena de Restaurantes #{self.email}", email: self.email)
    restaurant = Restaurant.create(user_id: self.id, chain_id: chain.id, name: "Restaurante #{self.email}", email: self.email)
    settings = RestaurantSetting.create(restaurant_id: restaurant.id, name: "#{restaurant.name} - Ajustes", num_licenses: 1, supported_lang: ["", "es"], call_waiter_button: false, order_button: false, request_bill_button: false, show_help_button: false, sync_photos: true)
    
    # creating 10 tables
    table = nil
    10.downto(1) do |i|
      table = Table.create(restaurant_id: restaurant.id, number: i, name: "#{restaurant.name} - Mesa #{i}")
    end
    
    # creating one tablet with access key the email
    Tablet.create(table_id: table.id, name: "#{restaurant.name} - Tablet 1", access_key: "#{self.email}", active: true)
    
    # creating 3 simple survey questions
    SurveyQuestion.create(chain_id: chain.id, name: "#{restaurant.name} - servicio", description: "El servicio que le brindamos fue de su agrado?", position: 1, active: true)
    SurveyQuestion.create(chain_id: chain.id, name: "#{restaurant.name} - comida", description: "Te ha gustado la comida?", position: 2, active: true)
    SurveyQuestion.create(chain_id: chain.id, name: "#{restaurant.name} - carta", description: "Te ha gustado nuestra carta digital?", position: 3, active: true)
    
    # creating 3 restaurant banners
    RestaurantBanner.create(restaurant_id: restaurant.id, name: "Banner 1", position: 1, active: true)
    RestaurantBanner.create(restaurant_id: restaurant.id, name: "Banner 2", position: 2, active: true)
    RestaurantBanner.create(restaurant_id: restaurant.id, name: "Banner 3", position: 3, active: true)
    
    # creating menus and menu settings
    main_menu = Menu.create(restaurant_id: restaurant.id, name: "Carta Principal", menu_type: 'main')
    daily_menu = Menu.create(restaurant_id: restaurant.id, name: "Menu del Dia", menu_type: 'daily', price: 10.5, theme_id: Theme.find_by_name("Modern").id)
    desserts_menu = Menu.create(restaurant_id: restaurant.id, name: "Carta de Postres", menu_type: 'desserts', theme_id: Theme.find_by_name("Minimalist").id)
    
    main_menu_settings = MenuSetting.create(menu_id: main_menu.id, name: "#{main_menu.name} - Ajustes", active: true)
    daily_menu_settings = MenuSetting.create(menu_id: daily_menu.id, name: "#{daily_menu.name} - Ajustes", active: true)
    desserts_menu_settings = MenuSetting.create(menu_id: desserts_menu.id, name: "#{desserts_menu.name} - Ajustes", active: true)
    
    # creating sections for main menu and daily menu
    section_salads = Section.create(menu_id: main_menu.id, name: 'Ensaladas', active: true)
    section_beef = Section.create(menu_id: main_menu.id, name: 'Carnes', active: true)
    section_firsts = Section.create(menu_id: daily_menu.id, name: 'Primeros', active: true)
    section_seconds = Section.create(menu_id: daily_menu.id, name: 'Segundos', active: true)
    section_desserts = Section.create(menu_id: daily_menu.id, name: 'Postres', active: true)
    section_special_desserts = Section.create(menu_id: desserts_menu.id, name: 'Postres', active: true)
    
    # creating dishes for these menus
    salad_1 = Dish.create(name: 'Ensalada Capresa', description: 'Nuestra ensalada capresa está hecha a base de lechuga fresca, tomate natural y queso mozzarella.', active: true, rate_me: true, price: 7, chain_id: chain.id, position: 1, section_ids: [section_salads.id, section_firsts.id])
    salad_2 = Dish.create(name: 'Ensalada Cesar', description: 'La ensalada cesar contiene lechuga, trozos de pollo y salsa cesar con un toque de aceite balsámico.', active: true, rate_me: true, price: 8, chain_id: chain.id, position: 2, section_ids: [section_salads.id, section_firsts.id])
    beef_1 = Dish.create(name: 'Bife de Chorizo', description: 'Jugosa carne de 500gr hecha al mas auténtico estilo argentino.', active: true, rate_me: true, price: 18, chain_id: chain.id, position: 1, section_ids: [section_beef.id, section_seconds.id])
    beef_2 = Dish.create(name: 'Hamburguesa Especial', description: 'Una hamburguesa especial de la casa, hecha con 250gr de carne a la parrilla, lechuga, tomate y pepinillos.', active: true, rate_me: true, price: 12, chain_id: chain.id, position: 2, section_ids: [section_beef.id, section_seconds.id])
    dessert_1 = Dish.create(name: 'Bomba de Chocolate', description: 'Una auténtica explosión del más rico chocolate.', active: true, rate_me: true, price: 5, chain_id: chain.id, position: 1, section_ids: [section_desserts.id, section_special_desserts.id])
    dessert_2 = Dish.create(name: 'Cheese Cake', description: 'La clásica tarta de queso hecha cada día por nuestro chef con un toque tradicional.', active: true, rate_me: true, price: 5, chain_id: chain.id, position: 2, section_ids: [section_desserts.id, section_special_desserts.id])
    
    
    return true
  end
  
  CHAIN_DEMO_NAME = 'Wogaboo'
  RESTAURANT_DEMO_NAME = 'Wogaboo Las Tablas'
  
  def clone_mw_restaurant_demo
    Restaurant.find_by_name(RESTAURANT_DEMO_NAME).clone_me(self)
  end

  # Create new Restaurant for meWaiter
  def create_mw_restaurant
    if self.has_role? :restaurant
      chain = Chain.create(user_id: self.id, name: "Restaurantes #{self.email}", logo: DEF_LOGO, email: self.email)
      restaurant = Restaurant.create(user_id: self.id, chain_id: chain.id, name: "Restaurante #{self.email}", email: self.email)
      settings = RestaurantSetting.create(restaurant_id: restaurant.id, name: "#{restaurant.name} - Ajustes", num_licenses: 1)
      # creating 8 tables in la terraza
      floor = Floor.create(name: 'Terraza',restaurant_id: restaurant.id)
      8.downto(1) do |i|
        Table.create(restaurant_id: restaurant.id, floor_id: floor.id, number: i, name: "#{floor.name} Mesa #{i}")
      end
      # creating 8 tables in main area
      floor = Floor.create(name: 'Principal',restaurant_id: restaurant.id)
      8.downto(1) do |i|
        Table.create(restaurant_id: restaurant.id, floor_id: floor.id, number: i, name: "#{floor.name} Mesa #{i}")
      end
      # creating one waiter access
      Waiter.create(restaurant_id: restaurant.id, first_name: self.name, last_name: self.surname, email: self.email, password: 'demo', key: self.email, active: true)
      #TODO create resources (tickets)
      #TODO create menus, sections, subsections, dishes and modifiers
    end
  end

end
