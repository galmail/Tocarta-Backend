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
  belongs_to :user
  belongs_to :chain
  has_one  :restaurant_setting
  has_many :restaurant_activities
  has_many :restaurant_banners
  has_many :menus
  has_many :waiters
  has_many :modifiers
  has_many :wines
  has_many :combos
  has_many :combo_types
  has_many :tables
  has_many :comments
  attr_accessible :name, :manager, :email, :address, :phone, :note, :chain_id, :user_id, :sd_location_id
  validates :chain_id, :presence => true

  def tablets
    self.tables.collect { |table| table.tablets }.flatten.select { |tablet| tablet.active }
  end

  def active_menus
    self.menus.select { |menu| menu.activated }
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
            
            
            # get dish description / details / attributes
            # get dish modifiers (create the modifiers if necesary)
            
            
            
            current_dish = Dish.create(chain_id: self.chain.id , name: dish[1], price: dish[2], sd_dish_id: dish[0])
            current_dish.sections << sect
          end
        end
      end

      logger.info "********* Save!"
      self.save!
    end
  end

end
