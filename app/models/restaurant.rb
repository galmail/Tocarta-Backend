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
      sd_categories = sd.get_menu_categories [location, 0, 1, 0, 0]

      logger.info "********* create sections"
      sd_categories[1].each do |category|
        #TODO: Get photo from SD if defined
        sect = menu.sections.create!(name: category[1], photo: File.new(def_section_img, 'r'), sd_category_id: category[0])

        logger.info "********* get sd dishes"
        sd_dishes = sd.get_menu_items_for_location_by_category [location, category[0], 1, 0], true
        logger.info "********* create dishes"
        sd_dishes[1].each do |dish|
          dish = sect.dishes.build( name: dish[1], description: dish[2], price: dish[3], sd_dish_id: dish[0] )
        end
      end

      logger.info "********* Save!"
      self.save!
    end
  end

end
