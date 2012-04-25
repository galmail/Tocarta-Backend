namespace :dish_sections_migration do
  
  # rails g model dish_section_association dish:references section:references
  # rake db:migrate
  # rails g model dish_subsection_association dish:references subsection:references
  # rake db:migrate
  
  ### Add to models created ###
  
  # validates_uniqueness_of :dish_id, :scope => :section_id
  # validates_uniqueness_of :dish_id, :scope => :subsection_id
  
  ### Run this on the console ###
  
  # Dish.all.each { |dish| ds = DishSectionAssociation.new; ds.dish = dish; ds.section = dish.section; ds.save; }
  # Dish.all.each { |dish| if !dish.subsection.nil?; ds = DishSubsectionAssociation.new; ds.dish = dish; ds.subsection = dish.subsection; ds.save; end; }
  
  ### Change model Dish ###
  
  # has_many :sections, :through => :dish_section_associations
  # has_many :dish_section_associations
  # has_many :subsections, :through => :dish_subsection_associations
  # has_many :dish_subsection_associations
  
  # delete belongs_to section and subsection
  # change attr_accessible :section_id to section_ids
  
  ### Change model Section ###
  
  # has_many :dishes, :through => :dish_section_associations
  # has_many :dish_section_associations
  
  ### Change model Subsection ###
  
  # has_many :dishes, :through => :dish_subsection_associations
  # has_many :dish_subsection_associations
  
  ### Delete columns section_id and subsection_id in dishes ###
  
  # rails g migration remove_columns_section_and_subsection_from_dishes
  # def change
    # remove_column :dishes, :section_id
    # remove_column :dishes, :subsection_id
  # end
  
  # rake db:migrate
  
  ### Files changed ###
  
  # config/initializers/rails_admin.rb
  # config/initializers/paperclip.rb
  # app/models/ability.rb
  
  
end
