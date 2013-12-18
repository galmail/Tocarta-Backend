child @discounts do
  attributes :sid, :name, :dtype, :amount
  
  attributes :position, :if => lambda { |d| !d.position.nil? }
  attributes :note, :if => lambda { |d| !d.note.nil? }
  
  attributes :restaurant_id, :if => lambda { |d| !d.restaurant.nil? }
  attributes :menu_id, :if => lambda { |d| !d.menu.nil? }
  attributes :section_id, :if => lambda { |d| !d.section.nil? }
  attributes :subsection_id, :if => lambda { |d| !d.subsection.nil? }
  attributes :dish_id, :if => lambda { |d| !d.dish.nil? }
  
end