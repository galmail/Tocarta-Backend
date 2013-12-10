class Printer < ActiveRecord::Base
  belongs_to  :restaurant
  has_many    :menus
  has_many    :sections
  has_many    :subsections
  has_many    :floors
  
  attr_accessible :name, :model, :ip_and_port, :number, :primary_backup_printer, :secondary_backup_printer
  attr_accessible :restaurant_id, :menu_ids, :section_ids, :subsection_ids, :floor_ids
  
  validates :name, :presence => true, :uniqueness => true
  
end
