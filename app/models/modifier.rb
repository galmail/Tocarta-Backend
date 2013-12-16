class Modifier < ActiveRecord::Base
  include Utils
  before_save :generate_sid
  
  belongs_to  :restaurant
  belongs_to  :modifier_list
  
  attr_accessible :name, :sd_modifierid, :description, :price, :sid
  attr_accessible :restaurant_id, :modifier_list_id
  
  
  def complex_sid(parent_mlistset)
    if !self.modifier_list.nil? and !parent_mlistset.nil?
      return "#{self.sid}+#{self.modifier_list.sid}+#{parent_mlistset.sid}"
    elsif !self.modifier_list.nil?
      return "#{self.sid}+#{self.modifier_list.sid}"
    else
      return "#{self.sid}"
    end
  end
  
end
