class ModifierList < ActiveRecord::Base
  include Utils
  before_save :generate_sid
  
  belongs_to  :restaurant
  has_many    :modifiers
  belongs_to  :selected_modifier, :foreign_key => 'modifier_id', :class_name => "Modifier"
  
  has_many :modifier_list_sets, :through => :modifier_list_set_associations
  has_many :modifier_list_set_associations
  attr_accessible :modifier_list_set_ids
  
  attr_accessible :name, :is_mandatory, :is_multioption, :modifier_ids, :sid
  attr_accessible :restaurant_id, :modifier_id
  
  
  def before_import_save(row, map)
    mlistset_association = ModifierListSetAssociation.new
    mlistset_association.modifier_list = self
    mlistset_association.modifier_list_set = ModifierListSet.find_by_sid row[6]
    begin
      mlistset_association.save
    rescue
      # already associated, do nothing...
    end
  end
  
end
