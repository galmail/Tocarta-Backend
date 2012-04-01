# RailsAdmin config file. Generated on March 15, 2012 10:25
# See github.com/sferik/rails_admin for more informations

RailsAdmin.config do |config|

  config.authorize_with :cancan
  # config.authenticate_with {}


  # If your default_local is different from :en, uncomment the following 2 lines and set your default locale here:
  require 'i18n'
  I18n.default_locale = :es

  config.current_user_method { current_user } # auto-generated

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

  #  ==> Global models configuration
  config.models do
    # Configuration here will affect all included models in all scopes, handle with care!
  
    list do
      # Configuration here will affect all included models in list sections (same for show, export, edit, update, create)
      exclude_fields :created_at, :updated_at
      
      fields_of_type :date do
        # Configuration here will affect all date fields, in the list section, for all included models. See README for a comprehensive type list.
      end
      
      # field :name do
        # label "Nombre"
      # end
      
    end
  end
  
  ######## Chain Model ########
  
  config.model Chain do
    label 'Cadena'
    label_plural 'Cadenas'
    list do
      exclude_fields :id, :user, :address, :note, :survey_questions
    end
  end
  
  ######## Restaurant Model ########
  
  config.model Restaurant do
    label 'Restaurante'
    label_plural 'Restaurantes'
    list do
      exclude_fields :id, :user, :note, :restaurant_activities, :restaurant_banners, :menus, :combos, :combo_types, :tables, :comments, :restaurant_setting
      field :chain do
        label "Cadena"
      end
    end
  end
  
  ######## RestaurantSetting Model ########
  
  config.model RestaurantSetting do
    label 'Ajustes'
    label_plural 'Ajustes'
    list do
      exclude_fields :id, :name, :default_language, :last_menu_sync, :multilang_homepage, :games
    end
    edit do
      exclude_fields :id, :name, :default_language, :last_menu_sync, :multilang_homepage, :games
      field :num_licenses do
        read_only true
      end
    end
  end
  
  ######## Menu Model ########
  
  config.model Menu do
    label 'Menu'
    label_plural 'Menus'
    list do
      exclude_fields :id, :theme, :menu_setting, :sections
    end
  end
  
  ######## DishType Model ########
  
  config.model DishType do
    label 'Tipo de Comida'
    label_plural 'Tipos de Comida'
    list do
      exclude_fields :id, :position, :dish_class, :dish_type_associations, :dishes
    end
  end
  
  ######## Dish Model ########
  
  config.model Dish do
    label 'Plato'
    label_plural 'Platos'
    list do
      exclude_fields :id, :combo, :description, :rating, :reviews, :story, :video, :nutrition_facts, :photo
      exclude_fields :badge_name, :short_title, :order_items, :comments, :dish_variations, :dish_type_associations, :dish_types
    end
    edit do
      exclude_fields :id, :combo, :reviews, :story, :video, :nutrition_facts
      exclude_fields :order_items, :comments, :dish_variations, :dish_type_associations
      field :rating do
        read_only true
      end
    end
  end
  
  ######## Section Model ########
  
  config.model Section do
    label 'Seccion'
    label_plural 'Secciones'
    list do
      exclude_fields :id, :menu, :hasBigSubsections, :dishes, :subsections
    end
    edit do
      exclude_fields :dishes, :subsections
    end
  end
  
  ######## Subsection Model ########
  
  config.model Subsection do
    label 'Subseccion'
    label_plural 'Subsecciones'
    list do
      exclude_fields :id, :dishes
    end
    edit do
      exclude_fields :id, :dishes
    end
  end
  
  ######## Comment Model ########
  
  config.model Comment do
    label 'Comentario'
    label_plural 'Comentarios'
    list do
      exclude_fields :client
    end
    edit do
      field [:dish, :restaurant, :client, :survey_question, :name, :description, :rating] do
        read_only true
      end
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
