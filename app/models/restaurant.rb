# == Schema Information
#
# Table name: restaurants
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  chain_id   :integer
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  manager    :string(255)
#  email      :string(255)
#  address    :string(255)
#  phone      :string(255)
#  note       :text
#

class Restaurant < ActiveRecord::Base
  after_save  :create_rest_settings
  belongs_to :user
  belongs_to :chain
  has_one  :restaurant_setting, :dependent => :destroy
  has_many :restaurant_activities, :dependent => :destroy
  has_many :restaurant_banners, :dependent => :destroy
  has_many :waiters, :dependent => :destroy
  has_many :resources, :dependent => :destroy
  has_many :menus, :dependent => :destroy
  has_many :discounts, :dependent => :destroy
  has_many :modifiers
  has_many :modifier_lists
  has_many :modifier_list_sets
  has_many :wines
  has_many :combos, :dependent => :destroy
  has_many :combo_types, :dependent => :destroy
  has_many :tables, :dependent => :destroy
  has_many :floors, :dependent => :destroy
  has_many :payments, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  attr_accessible :name, :manager, :email, :address, :phone, :note, :suggestions, :chain_id, :user_id, :sd_location_id, :pos_ip_address
  attr_accessor :mwpos
  
  ### Validations
  validates :chain_id, :presence => true
  validates :name, :presence => true, :uniqueness => true

  def tablets
    self.tables.collect { |table| table.tablets }.flatten.select { |tablet| tablet.active }
  end
  
  def active_list(aList)
    # filter discounts
    aList.reject!{|d| !d.active }
    # sort menus
    aList.sort_by!{|item|
      item_position = 9999
      if item[:position].is_a?(Numeric) == false
        item_position = 9999
      else
        item_position = item[:position]
      end
    }
    return aList
  end

  def active_menus
    # filter menus
    self.menus.reject!{|menu| !menu.activated } unless self.mwpos
    # sort menus
    self.menus.sort_by!{|item|
      item_position = 9999
      if item[:position].is_a?(Numeric) == false
        item_position = 9999
      else
        item_position = item[:position]
      end
    }
    return self.menus
  end

  def import_sd_menu!
    location = self.sd_location_id
    if location.blank?
      #TODO: recover error
    else
      def_section_img  = Rails.root.join('app','assets','images','default_section.png')

      sd = Subtledata.client(session_token: Subtledata.get_session_token)

      logger.info "********* menu build"
      menu = self.menus.create!(menu_type: 'main', name: 'Imported menu')

      logger.info "********* get sd categories"
      # sd_categories = sd.get_menu_categories [location, 0, 1, 0, 0]
      sd_categories = sd.get_local_pos_categories_for_location_by_parent_category [location, 0]

      logger.info "********* create sections"
      sd_categories[1].each do |category|
        #TODO: Get photo from SD if defined
        # sect = Section.create(menu_id: menu.id, name: category[1], photo: File.new(def_section_img, 'r'), sd_category_id: category[0])
        
        sect = Section.create(menu_id: menu.id, sd_category_id: category[0], name: category[2], photo: File.new(def_section_img, 'r'))
        
        logger.info "********* get sd modifiers"
        # get modifiers of that section
        sd_modifiers = sd.get_modifiers_for_location_by_local_pos_category [location, category[0]]
        
        if !sd_modifiers.nil? and !sd_modifiers[1].nil?
          # create the modifier list
          mod_list = ModifierList.create(restaurant_id: self.id, name: category[2])
          sd_modifiers[1].each do |modifier|
            Modifier.create(restaurant_id: self.id, modifier_list_id: mod_list.id, sd_modifierid: modifier[0], name: modifier[1], description: modifier[2], price: modifier[3])
          end
        end

        logger.info "********* get sd dishes"
        # sd_dishes = sd.get_menu_items_for_location_by_category [location, category[0], 1, 0], true
        sd_dishes = sd.get_items_for_location_by_local_pos_category [location, category[0]]
        
        logger.info "********* create dishes"
        if !sd_dishes.nil? and !sd_dishes[1].nil?
          sd_dishes[1].each do |dish|
            current_dish = Dish.create(chain_id: self.chain.id , name: dish[1], price: dish[2], sd_dish_id: dish[0])
            current_dish.sections << sect
          end
        end
      end

      logger.info "********* Save!"
      self.save!
    end
  end
  
  def clone_me(user)
    # clone chain
    new_chain = self.chain.dup
    new_chain.user = user
    new_chain.name = "#{user.email} #{self.chain.name}"
    new_chain.save
    # clone this restaurant and assign to user
    new_rest = self.dup
    new_rest.chain = new_chain
    new_rest.user = user
    new_rest.name = "#{user.email} #{self.name}"
    new_rest.pos_ip_address = nil
    new_rest.save
    # clone restaurant setting and assign to user
    new_rest_setting = self.restaurant_setting.dup
    new_rest_setting.restaurant = new_rest
    new_rest_setting.save
    # clone tables and floors
    new_rest.floors.clear
    self.floors.each { |floor|
      new_floor = floor.dup
      new_floor.restaurant = new_rest
      new_floor.save
      new_floor.tables.clear
      floor.tables.each { |table|
        new_table = table.dup
        new_table.floor = new_floor
        new_table.restaurant = new_rest
        new_table.save
        new_floor.tables << new_table
      }
      new_floor.save
      new_rest.floors << new_floor
    }
    new_rest.save
    # clone waiter accounts
    new_rest.waiters.clear
    self.waiters.each { |waiter|
      new_waiter = waiter.dup
      new_waiter.restaurant = new_rest
      new_waiter.save
      new_rest.waiters << new_waiter
    }
    new_rest.save
    # clone resources (tickets)
    new_rest.resources.clear
    self.resources.each { |resource|
      new_resource = resource.dup
      new_resource.restaurant = new_rest
      new_resource.save
      new_rest.resources << new_resource
    }
    new_rest.save
    # clone menus
    new_rest.menus.clear
    self.menus.each { |menu|
      new_menu = menu.dup
      new_menu.restaurant = new_rest
      new_menu.save
      
      unless menu.menu_setting.nil?
        new_menu_setting = menu.menu_setting.dup
        new_menu_setting.menu = new_menu
        new_menu_setting.save
        new_menu.menu_setting = new_menu_setting
        new_menu.save
      end
      
      # clone sections, subsections and dishes
      new_menu.sections.clear
      menu.sections.each { |section|
        new_section = section.dup
        new_section.menu = new_menu
        new_section.save
        new_menu.sections << new_section
        unless section.subsections.nil? or section.subsections.empty?
          new_section.subsections.clear
          section.subsections.each { |subsection|
            new_subsection = subsection.dup
            new_subsection.section = new_section
            new_subsection.save
            new_section.subsections << new_subsection
            puts "************* COPY DISHES TO SUBSECTION *************"
            copy_dishes_to_subsection(new_subsection,subsection.dishes)
          }
          new_section.save
        else
          puts "************* COPY DISHES TO SECTION *************"
          copy_dishes_to_section(new_section,section.dishes)
        end
      }
      new_menu.save
      new_rest.menus << new_menu
    }
    new_rest.save
  end
  
  def create_rest_settings
    rest_setting = RestaurantSetting.new
    rest_setting.name = "Ajustes #{self.name}"
    rest_setting.restaurant = self
    rest_setting.num_licenses = 1
    rest_setting.access_key = "1111"
    rest_setting.default_language = "es"
    rest_setting.supported_lang = ["", "es"]
    begin
      rest_setting.save
    rescue
      # already exist, do nothing...
    end
  end
  
  private
  
  def copy_dishes_to_section(new_section,dishes)
    new_section.dishes.clear
    dishes.each { |dish|
      new_dish = dish.dup
      new_dish.sections.clear
      new_dish.sections << new_section
      new_dish.save
      copy_modifiers_to_dish(new_dish,dish.modifier_list_set)
    }
    new_section.save
  end
  
  def copy_dishes_to_subsection(new_subsection,dishes)
    new_subsection.dishes.clear
    dishes.each { |dish|
      new_dish = dish.dup
      new_dish.subsections.clear
      new_dish.sections.clear
      new_dish.subsections << new_subsection
      new_dish.sections << new_subsection.section
      new_dish.save
      copy_modifiers_to_dish(new_dish,dish.modifier_list_set)
    }
    new_subsection.save
  end
  
  def copy_modifiers_to_dish(new_dish,modifier_list_set)
    return false if modifier_list_set.nil?
    new_rest = new_dish.sections.first.menu.restaurant
    
    new_dish.modifier_list_set = nil
    new_dish.save
    
    modifier_list_set.modifier_lists.each { |mod_list|
      
      new_mod_list = mod_list.dup
      new_mod_list.restaurant = new_rest
      new_mod_list.modifier_list_sets.clear
      new_mod_list.modifiers.clear
      new_mod_list.save
      
      unless mod_list.modifiers.nil? or mod_list.modifiers.empty?
        mod_list.modifiers.each { |modifier|
          new_modifier = modifier.dup
          new_modifier.restaurant = new_rest
          new_modifier.modifier_list = new_mod_list
          new_modifier.save
        }
      end
      
    }
    
    new_dish.save
  end
  
  def assign_dishes_to_section(new_section,dishes)
    dishes.each { |dish|
      dish.sections << new_section
      dish.save
    }
  end
  
  def assign_dishes_to_subsection(new_subsection,dishes)
    dishes.each { |dish|
      dish.subsections << new_subsection
      dish.sections << new_subsection.section
      dish.save
    }
  end
  
end
