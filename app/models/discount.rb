class Discount < ActiveRecord::Base
  include Utils
  before_save :generate_sid
  
  # discount belongs to a restaurant and can be applied to a specific dish, subsection, section or menu.
  belongs_to  :restaurant
  belongs_to  :dish
  belongs_to  :subsection
  belongs_to  :section
  belongs_to  :menu
  
  attr_accessible :sid, :name, :note, :dtype, :amount, :active, :position
  attr_accessible :restaurant_id, :dish_id, :subsection_id, :section_id, :menu_id
  
  translates :name, :fallbacks_for_empty_translations => true
  
  def dtype_enum
    return ['percentage','fixed']
  end
  
end
