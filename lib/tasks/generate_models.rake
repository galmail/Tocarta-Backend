namespace :db do
  
  def fix_association(model,lines)
    puts "Fixing associations of model #{model}."
    file_name = ''
    if model.include?('::')
      file_name = model.split("::").first.underscore << '/' << model.split("::").last.underscore
    else
      file_name = model.underscore
    end
    
    file_to_read = File.open("app/models/#{file_name}.rb","r")
    old_associations = []
    file_to_read.rewind
    file_to_read.readline #skipping the first one
    file_to_read.each {|line|
      break if line.start_with?("end")
      old_associations << line
    }
    file_to_read.close
    
    file_to_write = File.new("app/models/#{file_name}.rb", "w+")
    file_to_write.puts("class #{model} < ActiveRecord::Base")
    old_associations.each { |line| file_to_write.puts(line) }
    lines.each { |line| file_to_write.puts("\t#{line}") }
    file_to_write.puts("end")
    file_to_write.close
    
    puts "Associations of model #{model} fixed."
  end
  
  def add_image_to_model(model,attr,image_path)
    image_path = image_path || 'img'
    #paperclip_attachment = ':storage => :s3,:path => "'+image_path+'",:bucket => "bucket_tocarta_staging",:s3_credentials => {:access_key_id => ENV["S3_KEY"],:secret_access_key => ENV["S3_SECRET"]}'
    sh "rails generate paperclip #{model.underscore} #{attr}"
    #fix_association(model,["has_attached_file :#{attr},#{paperclip_attachment}"])
    fix_association(model,["has_attached_file :#{attr}"])
  end
    
  task :testing do
    #action = 'rails generate model' #rails generate active_scaffold
    add_image_to_model('Subsection','photo','img/subsections/subsection_:id.:extension')
  end

  desc "Create All Models with ActiveScaffold"
  task :create_models do
    action = 'rails generate model' #rails generate active_scaffold
    
    # User
    sh "rails generate devise User"
    sh "rails generate rails_admin:install_migrations"
    fix_association('User',['has_one :chain','has_one :restaurant','has_one :client'])
    
    # Client
    sh "#{action} Client user:references name:string"
    fix_association('Client',['has_many :orders','has_many :comments'])
    
    # Chain
    sh "#{action} Chain user:references name:string"
    fix_association('Chain',['has_many :restaurants','has_many :survey_questions'])
    
    # Restaurant
    sh "#{action} Restaurant user:references chain:references name:string"
    fix_association('Restaurant',['has_one :restaurant_setting','has_many :restaurant_activities','has_many :menus','has_many :combos','has_many :combo_types','has_many :tables','has_many :comments'])    
    
    # RestaurantBanner
    sh "#{action} RestaurantBanner restaurant:references"
    fix_association('Restaurant',['has_many :restaurant_banners'])
    
    # RestaurantActivity
    sh "#{action} RestaurantActivity restaurant:references table:references order:references name:string"
    
    # RestaurantSetting
    sh "#{action} RestaurantSetting restaurant:references name:string"
    
    # Table
    sh "#{action} Table restaurant:references name:string"
    fix_association('Table',['has_many :orders','has_many :tablets','has_many :restaurant_activities'])
    
    # Tablet
    sh "#{action} Tablet table:references name:string"
    fix_association('Tablet',['has_many :orders'])
    
    # MenuSetting
    sh "#{action} MenuSetting menu:references name:string"
    
    # Menu
    sh "#{action} Menu restaurant:references theme:references name:string"
    fix_association('Menu',['has_one :menu_setting','has_many :sections'])
    
    # Theme
    sh "#{action} Theme name:string"
    fix_association('Theme',['has_many :menus'])
    
    # Section
    sh "#{action} Section menu:references name:string"
    fix_association('Section',['has_many :dishes','has_many :subsections'])
    
    # Subsection
    sh "#{action} Subsection section:references name:string"
    fix_association('Subsection',['has_many :dishes'])
    
    # Order
    sh "#{action} Order table:references tablet:references client:references name:string"
    fix_association('Order',['has_many :order_items','has_many :restaurant_activities'])
    
    # OrderItem
    sh "#{action} OrderItem order:references dish:references combo:references combo_type:references name:string"
    
    # DishType
    sh "#{action} DishType name:string"
    fix_association('DishType',['has_many :dish_type_associations','has_many :dishes, :through => :dish_type_associations'])
    
    # Dish
    sh "#{action} Dish combo:references section:references subsection:references name:string"
    fix_association('Dish',['has_many :order_items','has_many :comments','has_many :dish_variations','has_many :dish_type_associations','has_many :dish_types, :through => :dish_type_associations'])
    
    # DishTypeAssociation
    sh "#{action} DishTypeAssociation dish_type:references dish:references"
    
    # Combo
    sh "#{action} Combo combo_type:references restaurant:references name:string"
    fix_association('Combo',['has_many :dishes','has_many :order_items'])
    
    # ComboType
    sh "#{action} ComboType restaurant:references name:string"
    fix_association('ComboType',['has_many :combos','has_many :order_items'])
    
    # Comment
    sh "#{action} Comment dish:references restaurant:references client:references survey_question:references name:string"
    
    # SurveyQuestion
    sh "#{action} SurveyQuestion chain:references name:string"
    fix_association('SurveyQuestion',['has_many :comments'])
    
    # DishVariation
    sh "#{action} DishVariation dish:references name:string"
    
    ####### Adding Attachments to Models #######
    
    add_image_to_model('Chain','logo','img/chains/chain_:id.:extension')
    add_image_to_model('Section','photo','img/sections/section_:id.:extension')
    add_image_to_model('Subsection','photo','img/subsections/subsection_:id.:extension')
    add_image_to_model('RestaurantBanner','photo','img/banners/banner_:id.:extension')
    add_image_to_model('Dish','photo','img/dishes/dish_:id.:extension')
    add_image_to_model('DishType','icon','img/dish_types/dish_type_:id.:extension')
    add_image_to_model('DishVariation','photo','img/dish_variations/dish_variation_:id.:extension')
    #sh 'rake db:migrate'
    
  end
  
  desc "Destroy All Models with ActiveScaffold"
  task :destroy_models do
    action = 'rails destroy model' #rails destroy active_scaffold
    sh "rails destroy rails_admin:install_admin"
    sh "#{action} User"
    sh "#{action} Chain"
    sh "#{action} Restaurant"
    sh "#{action} RestaurantSetting"
    sh "#{action} Menu"
    sh "#{action} MenuSetting"
    sh "#{action} Section"
    sh "#{action} Subsection"
    sh "#{action} Dish"
    sh "#{action} DishType"
    sh "#{action} DishTypeAssociation"
    sh "#{action} Combo"
    sh "#{action} ComboType"
    sh "#{action} Comment"
    sh "#{action} SurveyQuestion"
    sh "#{action} DishVariation"
    sh "#{action} Table"
    sh "#{action} Tablet"
    sh "#{action} Order"
    sh "#{action} OrderItem"
    sh "#{action} RestaurantActivity"
  end

end


#cups = ENV["COFFEE_CUPS"] || 2
#puts "Made #{cups} cups of coffee. Shakes are gone."






