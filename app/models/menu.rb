# == Schema Information
#
# Table name: menus
#
#  id            :integer          not null, primary key
#  restaurant_id :integer
#  theme_id      :integer
#  name          :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  price         :decimal(, )
#  menu_type     :string(255)
#  skin_id       :integer
#

class Menu < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :skin
	has_one :menu_setting
	has_many :sections
	attr_accessible :name, :price, :menu_type, :skin_id, :restaurant_id
	translates :name, :fallbacks_for_empty_translations => true
	
	def menu_type_enum
    ['main','daily','beverages','wines','desserts']
  end
  
  ### Validations ###
  
  validates :menu_type, :restaurant_id, :presence => true
	
	def activated
	  settings = self.menu_setting
	  
	  return true if settings.nil?
	  return false if !settings.active
	  return true if settings.from_day.nil? and settings.to_day.nil? and settings.from_time.nil? and settings.to_time.nil? 
	  
	  time = Time.zone.now
	  
	  if settings.from_day_num.is_a?(Numeric) and settings.to_day_num.is_a?(Numeric)
	    if time.wday >= settings.from_day_num and time.wday <= settings.to_day_num
        puts "today is a valid day"
      else
        puts "today is NOT a valid day"
        return false
      end
	  end
	  
	  # comparing time in day
	  if settings.from_time.is_a?(Time) and settings.to_time.is_a?(Time)
	    this_time = Time.at(time.hour * 60 * 60 + time.min * 60 + time.sec)
      from_time = Time.at(settings.from_time.hour * 60 * 60 + settings.from_time.min * 60 + settings.from_time.sec)
      to_time = Time.at(settings.to_time.hour * 60 * 60 + settings.to_time.min * 60 + settings.to_time.sec)
      if this_time >= from_time and this_time <= to_time
        puts "now is a valid time during the day"
      else
        puts "now is NOT a valid time during the day"
        return false
      end
	  end
	  
	  return true
	end
	
  def dishtypes
    dishtypes = []
    self.sections.each { |section|
      section.dishes.each { |dish|
        dish.dish_types.each { |dt|
          dishtypes.push(dt)
        }
      }
    }
    return dishtypes.uniq
  end

  def before_import_save(row, map)
    self.set_permalink
    self.import_nested_data(row, map)
  end
	
end
