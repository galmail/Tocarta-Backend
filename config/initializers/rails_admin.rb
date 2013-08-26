# RailsAdmin config file. Generated on March 15, 2012 10:25
# See github.com/sferik/rails_admin for more informations


RailsAdmin.config do |config|

  config.authorize_with :cancan
  # config.authenticate_with {}

  # If your default_local is different from :en, uncomment the following 2 lines and set your default locale here:
  require 'i18n'
  I18n.default_locale = :es

  config.current_user_method { current_user } # auto-generated

  config.navigation_static_links = {
    # 'Profile' => '/users/edit'
    'Analytics' => '/dashboards'
  }

  # If you want to track changes on your models:
  # config.audit_with :history, User

  # Or with a PaperTrail: (you need to install it first)
  # config.audit_with :paper_trail, User

  # Set the admin name here (optional second array element will appear in a beautiful RailsAdmin red ©)
  config.main_app_name = ['Tocarta', 'Admin']
  # or for a dynamic name:
  # config.main_app_name = Proc.new { |controller| [Rails.application.engine_name.titleize, controller.params['action'].titleize] }


  #  ==> Global show view settings
  # Display empty fields in show views
  # config.compact_show_view = false

  #  ==> Global list view settings
  # Number of default rows per-page:
  # config.default_items_per_page = 20

  #  ==> Included models
  # Add all excluded models here:
  # config.excluded_models = []

  # Add models here if you want to go 'whitelist mode':
  # config.included_models = []

  # Application wide tried label methods for models' instances
  # config.label_methods << :description # Default is [:name, :title]

  config.actions do
    # root actions
    dashboard                     # mandatory
    # collection actions
    index                         # mandatory
    new
    export
    history_index
    bulk_delete
    # member actions
    show
    edit
    delete
    history_show
    show_in_app
    import do
      visible do
        bindings[:abstract_model].model.to_s == "Dish"
      end
    end
    update_tablet do
      # Make it visible only for tablets model.
      visible do
        bindings[:abstract_model].model.to_s == "Tablet"
      end
    end

  end

  #  ==> Global models configuration
  config.models do
    # Configuration here will affect all included models in all scopes, handle with care!

    list do
      # Configuration here will affect all included models in list sections (same for show, export, edit, update, create)
      exclude_fields :created_at, :updated_at

      fields_of_type :date do
        # Configuration here will affect all date fields, in the list section, for all included models. See README for a comprehensive type list.
      end

    end
  end
  
  ######## Agreement Model ########
  
  config.model Agreement do
    weight 999
    list do
      exclude_fields :id, :rol, :description
    end
    edit do
      exclude_fields :id, :rol, :description
    end
  end

  ######## User Model ########

  config.model User do
    label 'Users'
    label_plural 'Users'
    object_label_method :email
    list do
      exclude_fields :id, :reset_password_sent_at, :remember_created_at, :sign_in_count, :current_sign_in_at, :current_sign_in_ip, :restaurant, :client
    end
    edit do
      exclude_fields :id, :reset_password_sent_at, :remember_created_at, :sign_in_count, :current_sign_in_at, :current_sign_in_ip, :restaurant, :client
    end
  end
  
  ######## Chain Model ########
  
  config.model Chain do
    weight 10
    list do
      exclude_fields :id, :user, :address, :note, :survey_questions
    end
  end
  
  ######## Restaurant Model ########
  
  config.model Restaurant do
    weight 20
    list do
      exclude_fields :id, :user, :note, :restaurant_activities, :restaurant_banners, :menus, :combos, :combo_types, :tables, :comments, :restaurant_setting
    end
  end
  
  ######## RestaurantSetting Model ########
  
  config.model RestaurantSetting do
    parent Restaurant
    weight 2010
    list do
      exclude_fields :id, :name, :default_language, :last_menu_sync, :multilang_homepage, :games
    end
    update do
      exclude_fields :id, :name, :default_language, :last_menu_sync, :multilang_homepage, :games, :restaurant
      field :num_licenses do
        read_only true
      end
      field :supported_lang do
        render do
            bindings[:form].select( "supported_lang", bindings[:object].supported_lang_enum, {}, { :multiple => true })
        end
      end
    end
    create do
      exclude_fields :id, :default_language, :last_menu_sync, :multilang_homepage, :games
    end
  end
  
  ######## Menu Model ########
  
  config.model Menu do
    weight 30
    list do
      exclude_fields :id, :theme, :menu_setting, :sections
    end
  end
  
  ######## MenuSetting Model ########
  
  config.model MenuSetting do
    parent Menu
    weight 3010
    list do
      exclude_fields :id, :priority, :trigger_activation, :last_time_changed
    end
    edit do
      exclude_fields :id, :priority, :trigger_activation, :last_time_changed
    end
  end
  
  ######## Theme Model ########
  
  config.model Theme do
    weight 60
    # label 'Theme'
    # label_plural 'Themes'
    list do
      exclude_fields :id, :css, :created_at, :menus
    end
    edit do
      exclude_fields :id, :css, :menus
    end
  end
  
  ######## Skin Model ########
  
  config.model Skin do
    parent Menu
    weight 3020
    list do
      exclude_fields :id, :created_at, :menus, :user, :stylesheet
    end
    edit do
      exclude_fields :id, :menus
    end
  end
  
  ######## DishVariation Model ########
  
  config.model DishVariation do
    weight 80
    # label 'Dish Variation'
    # label_plural 'Dish Variations'
    list do
      exclude_fields :id, :position
    end
  end
  
  ######## DishVariationSet Model ########
  
  config.model DishVariationSet do
    weight 90
    # label 'Dish Variation Set'
    # label_plural 'Dish Variation Sets'
    list do
      exclude_fields :id, :dishes
    end
  end
  
  ######## DishType Model ########
  
  config.model DishType do
    weight 100
    # label 'Food Type'
    # label_plural 'Food Types'
    list do
      exclude_fields :id, :position, :dish_class, :dish_type_associations, :dishes
    end
  end
  
  ######## NutritionFact Model ########
  
  config.model NutritionFact do
    parent Dish
    weight 305010
    list do
      exclude_fields :id
    end
  end
  
  ######## Ingredient Model ########
  
  config.model Ingredient do
    parent Dish
    weight 305020
    list do
      exclude_fields :id
    end
  end
  
  ######## Dish Model ########
  
  config.model Dish do
    parent Menu
    weight 3050
    list do
      exclude_fields :id, :combo, :description, :reviews, :story, :video, :nutrition_facts, :photo
      exclude_fields :badge_name, :short_title, :order_items, :comments, :dish_variation_sets, :dish_variation_set_associations, :dish_type_associations, :dish_types, :dish_section_associations, :dish_subsection_associations
    end
    edit do
      exclude_fields :id, :combo, :reviews, :story, :nutrition_facts
      exclude_fields :order_items, :comments, :dish_variation_set_associations, :dish_type_associations, :dish_section_associations, :dish_subsection_associations
      field :rating do
        read_only true
      end
    end
  end
  
  ######## Section Model ########
  
  config.model Section do
    parent Menu
    weight 3030
    object_label_method do
      :section_label_method
    end
    list do
      exclude_fields :id, :menu, :hasBigSubsections, :subsections, :dishes, :dish_section_associations
    end
    edit do
      exclude_fields :subsections, :dishes, :dish_section_associations
    end
  end
  
  ######## Subsection Model ########
  
  config.model Subsection do
    parent Menu
    weight 3040
    list do
      exclude_fields :id, :dishes, :dish_subsection_associations
    end
    edit do
      exclude_fields :id, :dishes, :dish_subsection_associations
    end
  end
  
  ######## Comment Model ########
  
  config.model Comment do
    weight 140
    list do
      include_fields :created_at, :rating, :description, :name, :email, :dish, :tablet, :survey_question, :approved, :restaurant
      exclude_fields :id, :client
    end
    edit do
      include_fields :created_at, :rating, :description, :name, :email, :dish, :tablet, :survey_question, :approved, :restaurant
      exclude_fields :id, :client
    end
  end
  
  ######## Table Model ########
  
  config.model Table do
    parent Restaurant
    weight 2030
    object_label_method do
      :table_label_method
    end
    list do
      exclude_fields :id, :name, :language, :orders, :restaurant_activities
      include_fields :updated_at
      sort_by :updated_at
    end
    show do
      exclude_fields :id, :name, :language, :orders, :restaurant_activities
      include_fields :updated_at
    end
    create do
      exclude_fields :id, :name, :language, :status, :dinners, :tablets, :orders, :restaurant_activities
    end
  end
  
  ######## Tablet Model ########
  
  config.model Tablet do
    parent Restaurant
    weight 2040
    list do
      exclude_fields :id, :orders, :activated, :access_key, :display_size, :device_brand, :device_name, :device_os, :alive
    end
    show do
      exclude_fields :id, :alive, :orders
    end
  end
  
  ######## SurveyQuestion Model ########
  
  config.model SurveyQuestion do
    parent Restaurant
    weight 2020
    list do
      exclude_fields :id, :chain, :comments
      sort_by :position
    end
    edit do
      exclude_fields :id, :comments
    end
  end
  
  ######## Order Model ########
  
  config.model Order do
    weight 180
    object_label_method do
      :order_label_method
    end
    list do
      exclude_fields :tablet, :client, :restaurant_activities, :name, :note, :language
      include_fields :created_at
    end
    show do
      exclude_fields :client, :restaurant_activities, :name, :note, :language
      include_fields :created_at, :total
    end
  end
  
  ######## OrderItem Model ########
  
  config.model OrderItem do
    object_label_method do
      :order_item_label_method
    end
  end
  
  def order_item_label_method
    "#{self.quantity.to_s} #{self.name}"
  end
  
  def order_label_method
    "#{self.id.to_s}"
  end
  
  def table_label_method
    if !self.restaurant.nil?
      "#{self.restaurant.name} - #{self.number.to_s}"
    else
      "#{self.number.to_s}"
    end
  end
  
  def section_label_method
    if self.menu.nil?
      "#{self.name.to_s}"
    else
      "#{self.name.to_s} - #{self.menu.name.to_s}"
    end 
  end
  
  #
  #  ==> Model specific configuration
  # Keep in mind that *all* configuration blocks are optional.
  # RailsAdmin will try his best to provide the best defaults for each section, for each field.
  # Try to override as few things as possible, in the most generic way. Try to avoid setting labels for models and attributes, use ActiveRecord I18n API instead.
  # Less code is better code!
  # config.model MyModel do
  #   # Cross-section field configuration
  #   object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #   label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #   label_plural 'My models'      # Same, plural
  #   weight -1                     # Navigation priority. Bigger is higher.
  #   parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #   navigation_label              # Sets dropdown entry's name in navigation. Only for parents!
  #   # Section specific configuration:
  #   list do
  #     filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #     items_per_page 100    # Override default_items_per_page
  #     sort_by :id           # Sort column (default is primary key)
  #     sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     # Here goes the fields configuration for the list view
  #   end
  # end

  # Your model's configuration, to help you get started:

  # All fields marked as 'hidden' won't be shown anywhere in the rails_admin unless you mark them as visible. (visible(true))

end

RailsAdminImport.config do |config|
  config.model Dish  do
    # excluded_fields do
      # [:translation]
    # end
    label :name
  end
end
